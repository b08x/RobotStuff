@filter = lambda do |candidates|
  [candidates]
end

def drumkit(sample_name)

  if sample_name.instance_of?(Regexp)

    s = DRUMKITS, sample_name, @filter

  else
    s = DRUMKITS, sample_name

  end

  return s

end

def collection(name)
  tld = sample_paths COLLECTIONS

  samples = {}

  samples["COLLECTIONS"] = tld.map {|folder| Pathname.new(folder).to_s }.keep_if {|folders| folders.include?(name)}

  samples["COLLECTIONS"].map! {|x| Pathname.new(x).basename.to_s }

  return samples

end

# TODO: call `sample_free(sample_name)` when sample is no longer in use
#

# TODO: unload all samples with `sample_free_all`



#### TODO: `sample_paths` with return paths to all samples given a top-level directory

# a = sample_paths "/home/b08x/Library/sounds/collections/chromatic_thumps01/"

# a.each {|x| print x}
# {run: 18, time: 0.0}  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_35_kick.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_41_tom.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_43_tom.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_45_tom.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_47_tom.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_48_tom.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_50_tom.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_01_Hi.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_01_Hi_accent.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_01_Mid.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_01_Mid_accent.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_02_Hi.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_02_Hi_accent.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_02_Mid.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_02_Mid_accent.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_03_Hi.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_03_Hi_accent.flac"  ├─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_03_Mid.flac"  └─ "/home/b08x/Library/sounds/collections/chromatic_thumps01/20220204_808_03_Mid_accent.flac"

# load_samples(a)

####
