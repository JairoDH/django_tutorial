# Generated by Django 4.2.11 on 2024-04-27 17:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Categoria',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Abr', models.CharField(max_length=4)),
                ('Nombre', models.CharField(max_length=50)),
            ],
        ),
    ]
