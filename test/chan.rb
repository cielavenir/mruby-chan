assert("Chan skip elements") do
	ch=Chan.new{|ch|
		loop{
			raise if ch.peek!=ch.receive
			raise if ch.peek!=ch.receive
			ch<<ch.receive*2
		}
	}
	assert_equal ch.next?,false
	ch<<1
	assert_equal ch.next?,false
	ch<<2
	assert_equal ch.next?,false
	ch<<3
	assert_equal ch.next?,true
	assert_equal ch.peek,6
	assert_equal ch.next,6
end

assert("Chan gen_enum (chan) with loop") do
	assert_equal Chan.new{|ch|
		loop{
			ch.receive
			ch.receive
			ch<<ch.receive*2
		}
	}.gen_enum(Chan.new{|y|
		a=0
		b=1
		y<<a
		20.times{
			y<<b
			a,b=b,a+b
		}
	}).take(10),[2, 10, 42, 178, 754, 3194, 13530]
end

assert("Chan gen_enum (enumerator) without loop") do
	assert_equal Chan.new{|ch|
		#loop{
			ch.next
			ch.succ
			ch.send ch.receive*2
		#}
		ch.close
	}.gen_enum(Enumerator.new{|y|
		a=0
		b=1
		y<<a
		loop{
			y<<b
			a,b=b,a+b
		}
	}).take(10),[2]
end
