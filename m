From: paul@paul-moore.com (Paul Moore)
Date: Mon, 27 Mar 2017 14:23:47 -0400
Subject: selinux: Delete an error message for a failed memory allocation
	in policydb_read()
In-Reply-To: <36ca17b3-8afe-cb9c-05bb-d406d37361e6@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<c589a851-2bf6-c44f-1df7-11f242285a73@users.sourceforge.net>
	<CAHC9VhTf6LdUNJHV9G+YA=P1rj78v5WKG8v+QNoFGZ6DA+mDmQ@mail.gmail.com>
	<ecce7c5c-cbeb-5896-ec12-26c97619c102@users.sourceforge.net>
	<CAHC9VhTOnQ5uJtb16CuNtsvOOg3C4k1H6fm8ytWJRKc45K=eNw@mail.gmail.com>
	<36ca17b3-8afe-cb9c-05bb-d406d37361e6@users.sourceforge.net>
Message-ID: <CAHC9VhS81-9mFw8Eft8wf6C9MyDVGe8eB3Xvu8884-==5+H4mw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 27, 2017 at 1:56 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> ?, but I like the error message.
>
> How do you think about to pass the flag ?__GFP_NOWARN? if you like
> this information more than the default error reporting of the function ?kmalloc??

Possibly, although I would encourage you to just leave it as-is for
the moment.  Reviewing and merging patches carries a cost, and I would
very much prefer to allocate my time/resources on changes that have a
more significant impact.  I don't want to discourage your from
contributing to SELinux development, but I do want to strongly
encourage you to contribute more meaningful patches.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
