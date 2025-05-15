from rest_framework import permissions


class UserOwner(permissions.IsAuthenticated):
    message = 'Bạn không có quyền truy cập'

    # def has_permission(self, request, view):
    #     # Kiểm tra user hiện tại có phải là user trong url không
    #     return super().has_permission(request, view) and request.user == 

    def has_object_permission(self, request, view, user):
        return super().has_object_permission(request, view, user) and user == request.user


class IsStaff(permissions.IsAuthenticated):
    message = 'Bạn không có quyền truy cập'

    def has_permission(self, request, view):
        return super().has_permission(request, view) and request.user.is_staff


class InjectionOwner(permissions.IsAuthenticated):
    message = 'Bạn không có quyền truy cập'

    def has_object_permission(self, request, view, injection):
        return super().has_object_permission(request, view, injection) and injection.user == request.user

class NotificationOwner(permissions.IsAuthenticated):
    message = 'Bạn không có quyền truy cập'

    def has_object_permission(self, request, view, notification):
        return super().has_object_permission(request, view, notification) and notification.user == request.user

