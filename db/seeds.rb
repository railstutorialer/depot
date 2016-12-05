#---
# Excerpted from "Agile Web Development with Rails 5",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails5 for more book information.
#---
# encoding: utf-8
Product.delete_all
Product.create(title: 'Rails, Angular, Postgres, and Bootstrap',
  description:
    %{<p>
      <em>Powerful, Effective, and Efficient Full-Stack Web Development</em>
      As a Rails developer, you care about user experience and performance,
      but you also want simple and maintainable code. Achieve all that by
      embracing the full stack of web development, from styling with
      Bootstrap, building an interactive user interface with AngularJS, to
      storing data quickly and reliably in PostgreSQL. Take a holistic view of
      full-stack development to create usable, high-performing applications,
      and learn to use these technologies effectively in a Ruby on Rails
      environment.
      </p>},
  image_url: 'dcbang.jpg',
  price: 45.00,
  locale: 'en')
# . . .
Product.create(title: 'Seven Mobile Apps in Seven Weeks',
  description:
    %{<p>
      <em>Native Apps, Multiple Platforms</em>
      Answer the question “Can we build this for ALL the devices?” with a
      resounding YES. This book will help you get there with a real-world
      introduction to seven platforms, whether you’re new to mobile or an
      experienced developer needing to expand your options. Plus, you’ll find
      out which cross-platform solution makes the most sense for your needs.
      </p>},
  image_url: '7apps.jpg',
  price: 26.00,
  locale: 'en')
# . . .

Product.create(title: 'Ruby Performance Optimization',
  description:
    %{<p>
      <em>Why Ruby Is Slow, and How to Fix It</em>
      You don’t have to accept slow Ruby or Rails performance. In this
      comprehensive guide to Ruby optimization, you’ll learn how to write
      faster Ruby code—but that’s just the beginning. See exactly what makes
      Ruby and Rails code slow, and how to fix it. Alex Dymo will guide you
      through perils of memory and CPU optimization, profiling, measuring,
      performance testing, garbage collection, and tuning. You’ll find that
      all those “hard” things aren’t so difficult after all, and your code
      will run orders of magnitude faster.
      </p>},
  image_url: 'adrpo.jpg',
  price: 46.00,
  locale: 'en')

Product.create(title: 'Rails, Angular, Postgres, and Bootstrap ES',
  description:
    %{<p>
      <em>Powerful, Effective, and Efficient Full-Stack Web Development</em>
      Como desarrollador de Rails, le interesa la experiencia y el rendimiento del usuario,
      Pero también quiere código simple y de mantenimiento. Lograr todo eso por
      Abrazar la pila completa de desarrollo web, desde el estilo con
      Bootstrap, construyendo una interfaz de usuario interactiva con AngularJS, para
      Almacenar datos de forma rápida y confiable en PostgreSQL. Tome una visión holística de
      Desarrollo de pila completa para crear aplicaciones utilizables y de alto rendimiento,
      Y aprender a utilizar estas tecnologías de forma eficaz en un Ruby on Rails
      ambiente.
      </p>},
  image_url: 'dcbang.jpg',
  price: 45.00,
  locale: 'es')
# . . .
Product.create(title: 'Seven Mobile Apps in Seven Weeks ES',
  description:
    %{<p>
      <em>Native Apps, Multiple Platforms</em>
      Responde a la pregunta "¿Podemos construir esto para TODOS los dispositivos?" Con un
      Sonando SÍ. Este libro le ayudará a llegar con un mundo real
      Introducción a siete plataformas, ya sea nuevo para móviles o
      Desarrollador experimentado que necesita ampliar sus opciones. Además, usted encontrará
      Que la solución multiplataforma tiene más sentido para sus necesidades.
      </p>},
  image_url: '7apps.jpg',
  price: 26.00,
  locale: 'es')
# . . .

Product.create(title: 'Ruby Performance Optimization ES',
  description:
    %{<p>
      <em>Why Ruby Is Slow, and How to Fix It</em>
      No es necesario aceptar el rendimiento lento de Ruby o Rails. En esto
      Completa de la optimización Ruby, aprenderá a escribir
      Más rápido código Ruby, pero eso es sólo el comienzo. Vea exactamente lo que hace
      Ruby y código de Rails lento, y cómo solucionarlo. Alex Dymo te guiará
      A través de los peligros de la memoria y optimización de CPU, perfilado, medición,
      Pruebas de rendimiento, recolección de basura y ajuste. Usted encontrará que
      Todas esas cosas "duras" no son tan difíciles después de todo, y su código
      Ejecutará órdenes de magnitud más rápidas.
      </p>},
  image_url: 'adrpo.jpg',
  price: 46.00,
  locale: 'es')

t_check = Translation.create
t_check_en = TranslationRecord.create locale: 'en', text: 'Check'
t_check_es = TranslationRecord.create locale: 'es', text: 'Cheque'
t_check.translation_records << t_check_en
t_check.translation_records << t_check_es
t_check.save
t_credit_card = Translation.create
t_credit_card_en = TranslationRecord.create locale: 'en', text: 'Credit card'
t_credit_card_es = TranslationRecord.create locale: 'es', text: 'Tarjeta de crédito'
t_credit_card.translation_records << t_credit_card_en
t_credit_card.translation_records << t_credit_card_es
t_credit_card.save
t_purchase_order = Translation.create
t_purchase_order_en = TranslationRecord.create locale: 'en', text: 'Purchase order'
t_purchase_order_es = TranslationRecord.create locale: 'es', text: 'Orden de compra'
t_purchase_order.translation_records << t_purchase_order_en
t_purchase_order.translation_records << t_purchase_order_es
t_purchase_order.save

check = PayType.create label: 'Check'
check.name_translation = t_check
check.save
credit_card = PayType.create label: 'Credit card'
credit_card.name_translation = t_credit_card
credit_card.save
purchase_order = PayType.create label: 'Purchase order'
purchase_order.name_translation = t_purchase_order
purchase_order.save
