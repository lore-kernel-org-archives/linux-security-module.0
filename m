From: serge@hallyn.com (Serge E. Hallyn)
Date: Sun, 4 Jun 2017 11:25:25 -0500
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <CANA3KFV=K1=KUxBNv+Au2QZKaycT3yd2wFPSsW7L9LCChVavkg@mail.gmail.com>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<20170530205002.GA9841@srcf.ucam.org>
	<CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
	<0e0aa575-263a-893a-7ade-f2dc7ce679c2@schaufler-ca.com>
	<20170531153549.GB31189@mail.hallyn.com>
	<CANA3KFV=K1=KUxBNv+Au2QZKaycT3yd2wFPSsW7L9LCChVavkg@mail.gmail.com>
Message-ID: <20170604162525.GA643@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Peter Dolding (oiaohm at gmail.com):
> On Thu, Jun 1, 2017 at 1:35 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > Quoting Casey Schaufler (casey at schaufler-ca.com):
> >>
> >>
> >> On 5/31/2017 3:59 AM, Peter Dolding wrote:
> >> > ...
> >> >
> >> > Like you see here in Australian government policy there is another
> >> > thing called whitelisted.
> >> > https://www.asd.gov.au/publications/protect/top_4_mitigations_linux.htm
> >> > Matthew Garrett you might want to call IMA whitelisting Australian
> >> > government for one does not agree.  IMA is signed.   The difference
> >> > between signed and white-listed is you might have signed a lot more
> >> > than what a particular system is white-listed to allowed used.
> >> >
> >> To be clear, I'm all for a security module to support this policy.
> >> As the explicit requirement is for a whitelist, as opposed to allowing
> >> for a properly configured system*, you can't use any of the existing
> >> technologies to meet it. This kind of thing** is why we have a LSM
> >> infrastructure.
> >>
> >> Unfortunately, the implementation proposed has very serious issues.
> >> You can't do access control from userspace. You can't count on
> >> identifying programs strictly by pathname. It's much more complicated
> >> than it needs to be for the task.
> >>
> >> Suggestion:
> >>
> >> Create an security module that looks for the attribute
> >>
> >>       security.WHITELISTED
> >
> > Bonus, you can have EVM verify the validity of these xattrs, and
> > IMA verify the interity of the file itself.
> 
> Complete fail.   You have to think of a whitelist as a list you give
> to a security at a gate.
> 
> Shot-gunned all over the file system that you have to search down what
> is approved is not acceptable.
>
> I should be more clear you need a whitelist file to tick the box.

So you do what SELinux does.  You offer a list of 'at-boot' files which a
relabeling program goes over and measures.  But when it is time to check if
someone is allowed ot run a program, you check what is stored with the file
being run.  The security.WHITELISTED xattr :)  Not the list.  It was good
enough for CAPP and LSPP, should be good enough for your org.

If that doesn't suffice, then you will not be able to tick the box, and you
should go back to the people who drew the box and have them update their
requirements.  They're usually pretty interested.

> Where you can open up 1 file and see everything that is on the
> approved list.   Same with blacklist.   Think of it like a list of

That '1 file' is just a user interface/toolset issue.  It doesn't restrict
how the kernel implements it.

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
