module Reporting where

import Data.Monoid (getSum)

import qualified Database as DB
import Project

data Report = Report
    { budgetProfit :: Money
    , netProfit :: Money
    , difference :: Money
    } deriving (Eq, Show)
    
instance Semigroup Report where 
  (Report b1 n1 d1) <> (Report b2 n2 d2) = Report (b1 + b2) (n1 + n2) (d1 + d2)
  
instance Monoid Report where
  mempty = Report 0 0 0 

calculateReport :: Budget -> [Transaction] -> Report
calculateReport budget transactions =
    Report
      { budgetProfit = budgetProfit'
      , netProfit = netProfit'
      , difference = netProfit' - budgetProfit'
      } where
          budgetProfit' =  budgetIncome budget - budgetExpediture budget
          netProfit' = getSum (foldMap asProfit transactions)
          asProfit (Sale m) = pure m
          asProfit (Purchase m) = pure (negate m)

calculateProjectReport :: Project -> IO Report
calculateProjectReport = calculate 
    where 
      calculate (Project p _) = calculateReport <$> DB.getBudget p <*> DB.getTransactions p
      calculate (ProjectGroup _ projects) = foldMap calculate projects