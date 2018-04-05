GENERIC
   TYPE SortElement IS
         (<>);--type SortElement is any integer, modular, or enumeration type.

   WITH PROCEDURE Get (
         Job :    OUT SortElement);
   WITH PROCEDURE Put (
         Job : IN     SortElement);
   ItemKnt: Integer;

PACKAGE GenericTopologicalSort IS
   PROCEDURE TopologicalSort;
  END GenericTopologicalSort;

