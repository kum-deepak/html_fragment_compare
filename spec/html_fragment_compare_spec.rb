require 'spec_helper'

describe HtmlFragmentCompare do
  it 'has a version number' do
    expect(HtmlFragmentCompare::VERSION).not_to be nil
  end

  it 'should compares simple nodes' do
    # expect(HtmlCompare.compare('<h1 />', '<h1 />')).to eq(true)
    #
    # expect(HtmlCompare.compare('<h2 />', '<h1 />')).to eq(false)
    #
    # expect(HtmlCompare.compare('simple plain text', 'simple plain text')).to eq(true)

    expect(HtmlFragmentCompare.compare('simple plain text - different', 'simple plain text')).to eq(false)
  end

  it 'should check elements with attributes' do
    expect(HtmlFragmentCompare.compare('<h1 a="A" b="B" c=200 />', '<h1 a="A" b="B" c=200 />')).to eq(true)

    expect(HtmlFragmentCompare.compare('<h1 a="A" b="B" c=200 />', '<h1 b="B" c=200 a="A"  />')).to eq(true)

  end

  it 'should check elements with attributes in different order' do
    expect(HtmlFragmentCompare.compare('<h1 a="A" b="B1" c=200 />', '<h1 a="A" b="B" c=200 />')).to eq(false)

    expect(HtmlFragmentCompare.compare('<h1 a="A" b="B1" c=200 />', '<h1 b="B" c=200 a="A" />')).to eq(false)
  end

  it 'should ignore whitespaces' do
    expect(HtmlFragmentCompare.compare('<h1 a="A"        b="B1" c=200 />', '<h1 a="A" b=   "B"      c=200      />')).to eq(false)

    expect(HtmlFragmentCompare.compare('<h1 a="A" b="B1"     c=200 />', '<h1 b="B" c=200 a="A" />')).to eq(false)
  end

  it 'should compare children hierarchically' do
    s1= '
      <div class="show-image no-padding col-xs-12 col-sm-6 col-md-5">
        <a href="/kreatio/kreatio-blog/1000393/incremental-demographics" title="">
            <img alt="Incremental Demographics" src="/w-images/bcf25e0d-9fbe-4293-ba7c-58c0de9eaadd/2/demographics-154x190.jpg">
        </a>
      </div>
    '
    s2= '
      <div class="show-image no-padding col-xs-12 col-sm-6 col-md-5">
        <a title="" href="/kreatio/kreatio-blog/1000393/incremental-demographics">
            <img src="/w-images/bcf25e0d-9fbe-4293-ba7c-58c0de9eaadd/2/demographics-154x190.jpg" alt="Incremental Demographics" >
        </a>
      </div>
    '

    expect(HtmlFragmentCompare.compare(s1, s2)).to eq(true)
    expect(HtmlFragmentCompare.compare(s1, '')).to eq(false)
    expect(HtmlFragmentCompare.compare(s1 + "abc", s2)).to eq(false)
    expect(HtmlFragmentCompare.compare(s1, s2  + "abc")).to eq(false)
    expect(HtmlFragmentCompare.compare(s1 + "<div />", s2)).to eq(false)
    expect(HtmlFragmentCompare.compare(s1, s2  + "<p></p>")).to eq(false)

  end

  it 'should compare children hierarchically ignoring whitespace' do
    s1= '
      <div class="show-image no-padding col-xs-12 col-sm-6 col-md-5">
        <a href="/kreatio/kreatio-blog/1000393/incremental-demographics" title="">
            <img alt="Incremental Demographics" src="/w-images/bcf25e0d-9fbe-4293-ba7c-58c0de9eaadd/2/demographics-154x190.jpg">
        </a>
      </div>
    '
    s2= '
      <div class = "show-image no-padding col-xs-12 col-sm-6 col-md-5"  >
        <a title=""     href="/kreatio/kreatio-blog/1000393/incremental-demographics">

            <img     src="/w-images/bcf25e0d-9fbe-4293-ba7c-58c0de9eaadd/2/demographics-154x190.jpg" alt="Incremental Demographics" >

        </a>
      </div>
    '

    expect(HtmlFragmentCompare.compare(s1, s2)).to eq(true)
    expect(HtmlFragmentCompare.compare(s1, '')).to eq(false)
    expect(HtmlFragmentCompare.compare(s1 + "abc", s2)).to eq(false)
    expect(HtmlFragmentCompare.compare(s1, s2  + "abc")).to eq(false)
    expect(HtmlFragmentCompare.compare(s1 + "<div />", s2)).to eq(false)
    expect(HtmlFragmentCompare.compare(s1, s2  + "<p></p>")).to eq(false)
  end

  it 'should ignore comments' do
    s1= '
      <!-- hello -->
      <div class="show-image no-padding col-xs-12 col-sm-6 col-md-5">
        <a href="/kreatio/kreatio-blog/1000393/incremental-demographics" title="">
            <img alt="Incremental Demographics" src="/w-images/bcf25e0d-9fbe-4293-ba7c-58c0de9eaadd/2/demographics-154x190.jpg">
        </a>
      </div>
    '
    s2= '
      <div class="show-image no-padding col-xs-12 col-sm-6 col-md-5">
        <a title="" href="/kreatio/kreatio-blog/1000393/incremental-demographics">
            <img src="/w-images/bcf25e0d-9fbe-4293-ba7c-58c0de9eaadd/2/demographics-154x190.jpg" alt="Incremental Demographics" >
        </a>
      <!-- world -->
      </div>
      <!--<p>
        <span></span>
      </p>-->
    '
    expect(HtmlFragmentCompare.compare(s1, s2)).to eq(true)
  end
end
