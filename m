From: oiaohm@gmail.com (Peter Dolding)
Date: Sun, 4 Jun 2017 12:43:10 +1000
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <20170531153549.GB31189@mail.hallyn.com>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<20170530205002.GA9841@srcf.ucam.org>
	<CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
	<0e0aa575-263a-893a-7ade-f2dc7ce679c2@schaufler-ca.com>
	<20170531153549.GB31189@mail.hallyn.com>
Message-ID: <CANA3KFV=K1=KUxBNv+Au2QZKaycT3yd2wFPSsW7L9LCChVavkg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jun 1, 2017 at 1:35 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Quoting Casey Schaufler (casey at schaufler-ca.com):
>>
>>
>> On 5/31/2017 3:59 AM, Peter Dolding wrote:
>> > ...
>> >
>> > Like you see here in Australian government policy there is another
>> > thing called whitelisted.
>> > https://www.asd.gov.au/publications/protect/top_4_mitigations_linux.htm
>> > Matthew Garrett you might want to call IMA whitelisting Australian
>> > government for one does not agree.  IMA is signed.   The difference
>> > between signed and white-listed is you might have signed a lot more
>> > than what a particular system is white-listed to allowed used.
>> >
>> To be clear, I'm all for a security module to support this policy.
>> As the explicit requirement is for a whitelist, as opposed to allowing
>> for a properly configured system*, you can't use any of the existing
>> technologies to meet it. This kind of thing** is why we have a LSM
>> infrastructure.
>>
>> Unfortunately, the implementation proposed has very serious issues.
>> You can't do access control from userspace. You can't count on
>> identifying programs strictly by pathname. It's much more complicated
>> than it needs to be for the task.
>>
>> Suggestion:
>>
>> Create an security module that looks for the attribute
>>
>>       security.WHITELISTED
>
> Bonus, you can have EVM verify the validity of these xattrs, and
> IMA verify the interity of the file itself.

Complete fail.   You have to think of a whitelist as a list you give
to a security at a gate.

Shot-gunned all over the file system that you have to search down what
is approved is not acceptable.

I should be more clear you need a whitelist file to tick the box.
Where you can open up 1 file and see everything that is on the
approved list.   Same with blacklist.   Think of it like a list of
invited guests given to a security guard at a door.   You can check
who is invited by look at that list.     Attribute is like saying if
the person has X id let them in and going to the guard at the door to
see who is let in is not going to help you.

Of course just because the guard at door is letting people on the list
in does not mean they are not checking ids as well.   This is not an
either or issue this is an add a feature.

So whitelist file and Attribute in production usage function way
differently.   You don't want to have to scan a complete filesystem
all the time looking for stray set attributes.

Whitelist and Blacklisting fits into IMA not LSM really.    Because
you need to be able to use other LSM at the same time as
white/blacklists.

EVM and attributes  they are so easy to use that implement
whitelist/blacklist files has not be done.  Including means to sign
whitelist files to prevent modification when required.

So what both of you are suggest is not the right item to tick the box
to claim Linux has whitelist support.

Linux has hacks to implement whitelist support not properly whitelist
support that is functional in the right way.

Whitelist functional in the right way look in 1 location know what is set.

Also IMA support for containers is kind required supporting
whitelist/blacklist files because setting everything into attribute
can become very impractical.

So this is something that is missing.

Peter Dolding
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
