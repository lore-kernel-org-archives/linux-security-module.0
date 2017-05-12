From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 11 May 2017 22:37:18 -0500
Subject: setcap/getcap limitations
In-Reply-To: <20170511211146.GZ25861@madcap2.tricolour.ca>
References: <20170511211146.GZ25861@madcap2.tricolour.ca>
Message-ID: <20170512033718.GA29494@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Richard Guy Briggs (rgb at redhat.com):
> Capabilities gurus,

I cc:d Andrew as he maintains the source package,

> These may arguably be useless or meaningless combinations, but I found them
> sufficiently puzzling as to need to document and report the behaviour.  They
> appear to be leftovers from a time when fE may have been a bitfield rather than
> a boolean.
> 
> 
> 1 - BUG: setcap manpage refers to non-existant cap_from_text(3) and cap_set_file(3)
> manpages (fedora).  (It turns out it is in libcap-devel which makes
> sense, but isn't very useful for users of setcap/getcap(8) rather than
> developers.)

Hm, yeah, I suppose.  In the libcap source though they all come
together.  Perhaps this is cause for distro bugs to make a
common libcap-doc package which both libcap-devel and libcap2-bin
depend on?  Really not sure of the best solution.

> 2 - BUG: setcap requires dummy capability present to set or clear effective bit

Getting ready for a short road trip, will look at the rest this weekend.

> While attempting to issue the setcap command to set or clear the effective bit,
> the latter of which is a boolean rather than a capability set, a fatal error
> was returned with a usage message that didn't make much sense:
> 	# setcap +e /tmp/test
> 	fatal error: Invalid argument
> 	usage: setcap [-q] [-v] (-r|-|<caps>) <filename> [ ... (-r|-|<capsN>) <filenameN> ]
>  	Note <filename> must be a regular (non-symlink) file.
> So in order to set it, I need to use a dummy capability, such as:
> 	# setcap cap_sys_admin+e /tmp/test
> 
> 
> 3- BUG: getcap doesn't show effective bit set if no other fP or fI bits are set
> 
> 	# setcap cap_sys_admin+pe /tmp/test
> 	# getcap /tmp/test
> 	/tmp/test = cap_sys_admin+ep
> 	# getfattr --absolute-names --e hex -n security.capability /tmp/test
> 	security.capability=0x0100000200002000000000000000000000000000
> 	# setfattr -n security.capability -v 0x0100000200000000000000000000000000000000 /tmp/test
> 	# getcap /tmp/test 
> 	/tmp/test =
> 	# getfattr --absolute-names --e hex -n security.capability /tmp/test
> 	security.capability=0x0100000200000000000000000000000000000000
> 	# setcap cap_sys_admin-p /tmp/test
> 	# getfattr --absolute-names --e hex -n security.capability /tmp/test
> 	# file: /tmp/test
> 	security.capability=0x0000000200000000000000000000000000000000
> So, getcap lies, where getfattr is more honest but awkward.
> 
> 
> Q: How do I set one fP capability and a different fI capability?
> 
> >From looking at the manpage for cap_from_text, it appears that capability sets
> can be specified in a similar manner to chmod(1), using "=", "+" and "-"
> operators, but pracitical poking doesn't seem to work that way.  "+" seems to
> work like "=" and "-" seems to clear all except the version field.
> Other than resorting to setfattr, how can I set something like
> cap_sys_admin+p with cap_audit_read,cap_audit_write,cap_audit_control+i ?
> 
> 
> 4 - BUG: The capabilities version doesn't get cleared when all cap bits are
> cleared.  This fools kernel into thinking there are fcaps set.
> 
> As can be seen above, if setcap is used with "<capability>-<p|e|i>" to unset
> capabilities then the version field is leftover, set.  Arguably the -r option
> should have been used to remove the attribute entirely, but in this case, the
> kernel assumes that capabilities are in use due to a valid version number
> present (VFS_CAP_REVISION_MASK).  This could be solved in the kernel by
> clearing that attribute field entirely if there are no values set other than
> the version number, or by having "has_cap" check for a value more than just the
> version number.  Is it possible to remove some capabilities from a file but not
> all?  Or is it intended to simply specify the new set of capabilities that are
> to be set and ignore or strip away the unwanted ones from the set?
> 
> 
> Thanks!
> 
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
