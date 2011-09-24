module AutoComplete
    (
    Trie()
    -- unit construction
    , empty ,singleton
    -- constructions
    ,fromList ,toList
    -- from file
    , constructFromFile
    -- Query
    , find
    )where
import qualified Data.Map as M
import Data.List (foldl')
data Trie a =  Trie {
                    value :: [a],
                    terminal :: Bool,
                    children :: M.Map a (Trie a)
                    } deriving (Show,Eq)

empty :: Trie a
empty = Trie { value = [] , terminal = False ,children = M.empty}

singleton :: [a] -> Trie a
singleton a = Trie {value = a,terminal = True,children= M.empty}

find :: Ord a => [a] -> Trie a -> Maybe [[a]]
find [] t = Just $ toList t
find (k:ks) t = case M.lookup k (children t) of 
                Nothing -> Nothing 
                Just t' -> find ks t'

addToChildren ::Ord a => a->Trie a-> Trie a -> Trie a 
addToChildren v t' t = t {children = M.insert v t' (children t)} 

insert ::Ord a=> [a] -> Trie a -> Trie a
insert [] t = t {terminal = True}
insert (k:ks) t = case M.lookup k (children t) of 
                    Nothing ->  addToChildren k (insert ks ((singleton (value t ++ [k])){terminal = False})) t
                    Just t' -> addToChildren k (insert ks t') t

fromList :: Ord a => [[a]] -> Trie a
fromList = foldr insert empty

isLeaf :: Trie a -> Bool
isLeaf = terminal 

toList :: Trie a -> [[a]]
toList t | isLeaf t = [value t] ++ leaf
       | otherwise =  leaf
            where leaf = M.fold f [] (children t)
                  f cs ls = toList cs ++ ls

constructFromFile :: String -> IO (Trie Char)
constructFromFile fname = do contents <- readFile fname 
                             return $ foldl' f empty (lines contents)
                                where f tr str = insert str tr
