-- Example implementations of bind, return and sequence for built-in Maybe type

module MaybeEx where

-- What Maybe type constructor looks like
-- data Maybe a = Just a | Nothing

returnMaybe :: a -> Maybe a
returnMaybe a = Just a

bindMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
Nothing `bindMaybe` f = Nothing
Just a `bindMaybe` f = f a

mapMaybe :: (a -> b) -> Maybe a -> Maybe b
mapMaybe f Nothing = Nothing
mapMaybe f (Just a) = Just (f a)

lift2Maybe :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
lift2Maybe f ma mb = (mapMaybe f ma) `bindMaybe` (`mapMaybe` mb)

sequenceMaybe :: [Maybe a] -> Maybe [a]
sequenceMaybe ls = foldr (\l acc -> lift2Maybe (:) l acc) (returnMaybe []) ls

returnMaybeExample = returnMaybe 7

bindMaybeExample1 = Just 7 `bindMaybe` (\x -> returnMaybe (x+1))
bindMaybeExample2 = Nothing `bindMaybe` (\x -> returnMaybe (x+1))
bindMaybeExample3 = Just 7 `bindMaybe` (\x -> returnMaybe (x+1)) `bindMaybe` (\y -> returnMaybe (y*5))

