WITH Ada.Text_IO; USE Ada.Text_Io;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
WITH GenericTopologicalSort;
PROCEDURE TopSortB IS
   ItemKnt, choice: Integer;
   TYPE Name IS (default, Betty, Mary, Sam, Joe, Tom, Bob);
   PACKAGE NameIO IS NEW Ada.Text_Io.Enumeration_IO(Name);
   use NameIO;

   PROCEDURE NameGet(Action: OUT Name) IS
   BEGIN
      NameIO.Get(Action);
   END NameGet;

   PROCEDURE NamePut(Action: In name) IS
   BEGIN
      NameIO.Put(Action);
   END NamePut;

   PROCEDURE IntegerGet(Action: OUT Integer) IS
   BEGIN
      Ada.Integer_Text_IO.Get(Action);
   END IntegerGet;

   PROCEDURE IntegerPut(Action: IN Integer) IS
   BEGIN
      Ada.Integer_Text_IO.Put(Action);
   END IntegerPut;

BEGIN
   Put_Line("Enter 1 to sort integers or 2 to sort names:");
   Get(Choice);
   CASE Choice IS
      WHEN 1 =>
          Put_Line("Enter the number of items:");
          get(ItemKnt);
          DECLARE
            PACKAGE IntTopSort IS NEW GenericTopologicalSort(Integer, IntegerGet, IntegerPut, ItemKnt);
            USE IntTopSort;
            BEGIN
               IntTopSort.topologicalSort;
            END;

      WHEN 2 =>
          Put_Line("Enter the number of items:");
          get(ItemKnt);
          DECLARE
             Package NameTopSort is new GenericTopologicalSort(Name, NameGet, NamePut, ItemKnt);
               USE NameTopSort;
            BEGIN
               NameTopSort.TopologicalSort;
            END;

       WHEN OTHERS =>
          Put_Line("Exiting Program...");
      end case;

END TopSortB;

