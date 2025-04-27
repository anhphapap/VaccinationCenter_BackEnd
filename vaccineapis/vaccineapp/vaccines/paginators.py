from rest_framework.pagination import PageNumberPagination


class CategoryPaginator(PageNumberPagination):
    page_size = 10

class VaccinePaginator(PageNumberPagination):
    page_size = 10

class InjectionPaginator(PageNumberPagination):
    page_size = 10

class VaccinationCampaignPaginator(PageNumberPagination):
    page_size = 10

class UserPaginator(PageNumberPagination):
    page_size = 10


