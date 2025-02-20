from django.shortcuts import render
from django.http import HttpResponse 
from .models import Name, Age
import random

def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")

def show_data(request):
    names = Name.objects.all()
    ages = Age.objects.all()
    context = {
        'names': names,
        'ages': ages,
    }
    return render(request, 'show_data.html', context)

def create_data(request):
    names = ['John', 'Doe', 'Jane', 'Carlos', 'Maria']
    ages = [23, 45, 32, 12, 54]
    name = random.choice(names)
    age = random.choice(ages)

    new_name = Name(name=name)
    new_name.save()
    
    new_age = Age(age=age)
    new_age.save()
    
    return HttpResponse(f"Added {name} with age {age}")
