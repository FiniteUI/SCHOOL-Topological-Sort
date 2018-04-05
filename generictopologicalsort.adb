WITH Ada.Text_IO; USE Ada.Text_IO;
WITH Ada.Integer_Text_IO; USE Ada.Integer_Text_IO;
with Ada.Unchecked_Conversion;
PACKAGE BODY GenericTopologicalSort IS

   TYPE Node;
   TYPE NodePointer IS ACCESS Node;
   TYPE Node IS TAGGED RECORD
      Suc: SortElement;
      Next: NodePointer;
   END RECORD;

   TYPE JobElement IS RECORD
      Count: Integer := 0;
      Top: NodePointer;
   END RECORD;

   FUNCTION IntToPointer IS NEW Ada.Unchecked_Conversion(Integer, NodePointer);
   --FUNCTION PointerToInt IS NEW Ada.Unchecked_Conversion(NodePointer, Integer);

   SortStructure: ARRAY(0..ItemKnt) OF JobElement;

   PROCEDURE TopologicalSort IS
      RelationKnt, f, r, remaining, K, counter: Integer;
      Precedent, Successor: SortElement;
      Pointer: NodePointer;
   BEGIN--Begin TopologicalSort
      FOR I IN 1..ItemKnt LOOP
         SortStructure(I).Count := 0;
         SortStructure(I).top := null;
      END LOOP;--End for, building linked list attached to array
      Remaining := ItemKnt;
      counter := 1;

      Put_Line("Enter the total number of relations:");
      Get(RelationKnt);
      FOR I IN 1..RelationKnt LOOP
         Pointer := NEW Node;
         Put("Enter first the precedent and then the successor for relation ");
         Put(I);
         put_line(": ");
         Get(Precedent); Get(Successor);
         SortStructure(SortElement'Pos(Successor)).count := SortStructure(SortElement'Pos(Successor)).count + 1;--Increase the count of items successor is waiting on
         Pointer.Suc := Successor;
         Pointer.Next := SortStructure(SortElement'Pos(Precedent)).Top;
         SortStructure(SortElement'Pos(Precedent)).Top := Pointer;
         EXIT WHEN Counter = RelationKnt;
         counter := counter + 1;
      END LOOP;--End for 1..RelationKnt building data structure

      r := 0;
      SortStructure(0).Count := 0;

      FOR k IN 1..ItemKnt LOOP
         IF (SortStructure(k).Count = 0) THEN
            SortStructure(r).Count := k;
            r := k;
         END IF;--End if ss(k).count = 0 linking qlink
      END LOOP;--End for 1..remaining
      f := SortStructure(0).Count;

      put_line("Result of topological sort:");
      WHILE (F /= 0) LOOP
         put(SortElement'Val(f)); new_line;
         Remaining := Remaining - 1;
         Pointer := SortStructure(f).Top;
         SortStructure(f).top := IntToPointer(0);
         WHILE (Pointer /= IntToPointer(0)) LOOP
            SortStructure(SortElement'Pos(Pointer.suc)).Count := SortStructure(SortElement'Pos(Pointer.suc)).Count - 1;
            IF (SortStructure(SortElement'Pos(Pointer.Suc)).Count = 0) THEN
               SortStructure(r).Count := SortElement'Pos(Pointer.Suc);
               r := SortElement'Pos(Pointer.Suc);
            END IF;
            Pointer := Pointer.Next;
         END LOOP;
         f := SortStructure(f).Count;
      END LOOP;

      IF (Remaining = 0) THEN
         Put_Line("The topological sort is complete.");
      ELSE
         Put_Line("Error: Loop detected");
         FOR K IN 1..ItemKnt LOOP
            SortStructure(K).Count := 0;
         END LOOP;
         FOR K IN 1..ItemKnt LOOP
            Pointer := SortStructure(K).Top;
            SortStructure(K).Top := IntToPointer(0);
            WHILE (Pointer /= IntToPointer(0) AND then (SortStructure(SortElement'Pos(Pointer.Suc)).Count = 0)) LOOP
               SortStructure(SortElement'Pos(Pointer.Suc)).Count := K;
                  IF (Pointer /= IntToPointer(0)) THEN
                  Pointer := Pointer.Next;
               END IF;
            END LOOP; --end while
         END LOOP;--end for

         K := 1;
         WHILE (SortStructure(K).Count = 0) LOOP
            K := K + 1;
         END LOOP;

        Loop
            SortStructure(K).Top := IntToPointer(1);
            K := SortStructure(K).Count;
            Exit When SortStructure(k).top /= IntToPointer(0);
         END LOOP;

         WHILE (SortStructure(K).Top /= IntToPointer(0)) LOOP
            Put(SortElement'Val(K)); new_Line;
               SortStructure(K).Top := IntToPointer(0);
               K := SortStructure(K).Count;
         END LOOP;

         put(SortElement'Val(k));

      end if;--end else from if remianing = 0
   END TopologicalSort;
END GenericTopologicalSort;

