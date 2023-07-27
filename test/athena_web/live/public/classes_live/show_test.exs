defmodule AthenaWeb.Public.ClassesLive.IndexTest do
  use AthenaWeb.ConnCase

  import Phoenix.LiveViewTest

  setup do
    class =
      build(:class,
        name: "Introduction to Elixir",
        description: "Learning the basics of the elixir language",
        class_text: class_text()
      )

    classes =
      for i <- 0..5 do
        build(:class, name: "Tuple #{i}")
      end

    elixir_course = insert(:course, name: "Elixir Course", classes: [class] ++ classes)

    %{course: elixir_course, class: class}
  end

  descrive "index" do
    test "will show the class that the user selected", %{course: course, class: class} do
      {:ok, view, _html} = live(conn, ~p"/courses/#{course.slug}/classes/#{class.slug}")

      view
      |> 
    end
  end

  defp class_text do
    ~s"""
    ## Argolicis templisque rerum quae quid mentita

    Lorem [markdownum](http://habuit.org/cui.php) sinistra qui, et manu, puer
    solitoque [arborei](http://habebat.io/), commune vidit animos! Voce ita omnia
    cervix Byblida [varios](http://www.sereno.org/se.html) equam locatas, modo
    prolem?

    > Vinaque Latina condiderat oranti adiecit ferro sterilique milite certe, *tota
    > ignotos trepidos*, habendum et inplet, corpora! Vehebat partibus quoque
    > instrumenta sibi bracchia consumpserat lora iustissimus neque vetustas: soceri
    > rerum, cupidine Phoronidos ea. Auro manifestam fremit. Flexi muro perdiderat
    > ramos domito; vacca quae sensu aristas volucres quid?

    ## Quoque nocendo dare matrisque perque arceor semper

    Altismunera multa vagantur et magna subiectum vicit *miserabilis patrias* venit.
    Satiata tonitrua lapidoso omnia. Diurnos nomen nam suis pariter Aeacide
    intercepta murra sanguine: totum.

    Diem qui iter inmisit natis litora pedum famuli meae fugiens **nobis**. Undique
    undis deus vestris missae in gurgite oscula Ianthe conserto auras adspiceres,
    sic tamen huc. Reparasque at videtur disque minuunt me amans es versarunt
    superstes. Ore laetissimus erat! Ad tellus arcusque Ulixes onerata summas
    thalamo, dapibus morati.

    ## Carpat ignes emeritis adhuc

    Tu Delius pallentem concitat dirae superest! Forte es silicem Hymenaee cum, ubi
    lamina veneno tua humo adstitit feritatis? Locutus domosque incipit cava icta
    traxit utraque morte [Ledam ducunt](http://iacit-limina.com/discaput.html)
    corpus, ferae aera quam securior flectimur, [raptam](http://talia.net/). Ille
    iura Desine sonuere *te sagittas barbae*, turba volumina praedam defenditur
    sceptro.

    Forma spargensque circinat iacent terra generisque usque obstiterit! Se vernat
    ultusque festa, veniat aera tanto una [dum](http://pharetram.com/praeferre).

    [Vel minis](http://undanarve.io/), sui quemque hominis purpureum in innuptaeque
    vidi. Quaerens et, mea in functus tumulo corpore tenebrosa, antistita scelerata
    Limyren esse solverat omnis.
    """
  end
end
