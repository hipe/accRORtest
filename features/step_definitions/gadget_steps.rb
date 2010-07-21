# Overview
Then /^I should see all of the gadgets that I've created$/ do
  Gadget.all.each do |g|
    assert page.has_content?(g.name)
  end  
end

Given /^I have a gadget called "([^"]*)"(?: that weighs (\d+) (\w+))?$/ do |gadget_name, weight, weight_unit|
  options = {:name => gadget_name}
  weight and weight_unit and options.merge!(:weight => weight, :weight_unit => weight_unit)
  Factory :gadget, options
end

When /^I click "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should be viewing the gadget detail page for "([^"]*)"$/ do |gadget_name|
  @gadget = Gadget.find_by_name(gadget_name)
  steps %Q{Then I should be on the detail page for that gadget}
end

# Detail
Given /^I am viewing the gadget detail page for "([^"]*)"$/ do |gadget_name|
  gadget = Gadget.find_by_name(gadget_name)
  visit(detail_gadget_path(gadget))
end

Then /^I should see that "([^"]*)" weighs (\d+) (\w+)$/ do |gadget_name, weight, weight_unit|
  gadget = Gadget.find_by_name(gadget_name)
  within("##{gadget.verbose_id}") do
    assert page.has_content?(gadget.complete_weight)
  end
end

Given /^the gadget called "([^"]+)" has (\d+) parts$/ do |gadget_name, num_parts|
  gadget_id = Gadget.find_by_name(gadget_name).id
  (1..num_parts.to_i).each do |count|
    Factory :part, :gadget_id => gadget_id, :name => "part number #{count}"
  end
end

Then /^I should see that "([^"]+)" has (\d+) parts$/ do |name, num|
  gadget = Gadget.find_by_name(name)

  # uh-oh: the below assertion is not really expressed in the desc. above
  assert_equal gadget.parts.size, num.to_i
  
  within("##{gadget.verbose_id}") do
    assert page.has_content?("#{num} parts")
  end
      
end

When /^I add a part called "([^"]+)" to "([^"]+)"$/ do |part_name, gadget_name|
  gadget = Gadget.find_by_name(gadget_name)
  Factory :part, :gadget_id => gadget.id, :name => part_name
end 

Then /^I should see "([^"]*)" within the parts for "([^"]*)"$/ do |part_name, gadget_name|
  gadget = Gadget.find_by_name(gadget_name)
  assert gadget, "found gadget named \"#{gadget_name}\""
  within("##{gadget.verbose_id}") do
    assert page.has_content?(gadget_name)
  end
end
