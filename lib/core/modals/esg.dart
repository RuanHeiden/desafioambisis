class Esg{
    final int id;
    final DateTime date;
    final int isComplete;
    final int type;

    Esg(
      this.id,
      this.date,
      this.isComplete,
      this.type,
    );

    @override
    String toString() {
    // TODO: implement toString
    return 'Esg - {id: $id, data: $date, isComplete: $isComplete, type: $type}';
  }
}