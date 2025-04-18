from rest_framework.pagination import PageNumberPagination


class CategoryPaginator(PageNumberPagination):
    page_size = 10

class VaccinePaginator(PageNumberPagination):
    page_size = 10
