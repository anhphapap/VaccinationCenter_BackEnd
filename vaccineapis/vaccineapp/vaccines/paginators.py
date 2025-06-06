from rest_framework.pagination import PageNumberPagination


class CategoryPaginator(PageNumberPagination):
    page_size = 5


class VaccinePaginator(PageNumberPagination):
    page_size = 5


class InjectionPaginator(PageNumberPagination):
    page_size = 5


class VaccinationCampaignPaginator(PageNumberPagination):
    page_size = 5


class UserPaginator(PageNumberPagination):
    page_size = 10

class DosePaginator(PageNumberPagination):
    page_size = 10

class OrderPaginator(PageNumberPagination):
    page_size = 5
