From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 23 Jun 2017 12:49:59 -0500
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <20170623170108.GA19354@mail.hallyn.com> (Serge E. Hallyn's
	message of "Fri, 23 Jun 2017 12:01:08 -0500")
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAOQ4uxj=_Riih1K+QOYasZU8vZKCSrsg393f=17mJ2O-909e=Q@mail.gmail.com>
	<20170623160026.GA18257@mail.hallyn.com>
	<aa62373e-7cd6-39dd-2e38-2b6d6dbe18a8@schaufler-ca.com>
	<20170623163030.GA18820@mail.hallyn.com>
	<ef37880d-6baa-12a6-eab1-bcd0a4e94d53@schaufler-ca.com>
	<20170623170108.GA19354@mail.hallyn.com>
Message-ID: <8760fmh9vc.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

"Serge E. Hallyn" <serge@hallyn.com> writes:

> Quoting Casey Schaufler (casey at schaufler-ca.com):
>> On 6/23/2017 9:30 AM, Serge E. Hallyn wrote:
>> > Quoting Casey Schaufler (casey at schaufler-ca.com):
>> >> Or maybe just security.ns.capability, taking James' comment into account.
>> > That last one may be suitable as an option, useful for his particular
>> > (somewhat barbaric :) use case, but it's not ok for the general solution.
>> 
>> security.ns at uid=100.capability
>
> I'm ok with this.  It gives protection from older kernels, and puts
> the 'ns at uid=' at predictable locations for security and trusted.
>
>> It makes the namespace part explicit and separate from
>> the rest of the attribute name. It also generalizes for
>> other attributes.
>> 
>> security.ns at uid=1000 at smack=WestOfOne.SMACK64
>
> Looks good to me.
>
> Do we want to say that '.' ends the attribute list?  That of
> course means '.' cannot be in the attributes.  Perhaps end
> with '@@' instead?  Just a thought.
>
> What do others think?

I think we have two things that will limit the allowed attributes
severely.

1) We need to the names of all of the xattrs when mounting a filesystem
   with s_user_ns != &init_user_ns.  I haven't yet checked the patches
   to see if they do this properly.

2) Names of xattrs are not fully general and filesystems perform various
   tricks to encode them more densely.  We should see what the games
   with xattr names do to how densely xattrs can be stored on disk.
   That matters.

Putting the uid of the root user in the name sounds fundamental to doing
things this way.  I am not at all certain about putting smack labels and
generally treating this as something we can add two arbitrarily.

If nothing else this reminds me of the frequent problem in
certifications with ouids.  Arbitrary attributes tend to defeat parsers
in a security context on a regular basis.  Even the kernel command line
parser has seen problems in this area, and it isn't security sensitive
most of the time.

Extensibility is good in the abstract long term sense.  Extensibility in
the here and now where we don't even know which attributes we are
talking about scares me.  I don't see how we can possibily know with
multiple attributes which xattrs will be the one to use.  As we won't
even know which properties of the kernel to look at to match attributes.

So while I don't mind reorganizing the order we put the information into
the attribute.  Let's keep what we place in there very specific.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
