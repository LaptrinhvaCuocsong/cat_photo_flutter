enum OrderBy { asc, desc }

String $OrderByToString(OrderBy order) {
  switch (order) {
    case OrderBy.asc:
      return 'asc';
    case OrderBy.desc:
      return 'desc';
    default:
      return '';
  }
}
