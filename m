From: paul@paul-moore.com (Paul Moore)
Date: Sat, 25 Mar 2017 11:44:45 -0400
Subject: selinux: Delete an error message for a failed memory allocation
	in policydb_read()
In-Reply-To: <ecce7c5c-cbeb-5896-ec12-26c97619c102@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<c589a851-2bf6-c44f-1df7-11f242285a73@users.sourceforge.net>
	<CAHC9VhTf6LdUNJHV9G+YA=P1rj78v5WKG8v+QNoFGZ6DA+mDmQ@mail.gmail.com>
	<ecce7c5c-cbeb-5896-ec12-26c97619c102@users.sourceforge.net>
Message-ID: <CAHC9VhTOnQ5uJtb16CuNtsvOOg3C4k1H6fm8ytWJRKc45K=eNw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 24, 2017 at 8:13 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>> Omit an extra message for a memory allocation failure in this function.
>>>
>>> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
>>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>>> ---
>>>  security/selinux/ss/policydb.c | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> I'm not going to remove an error message without some better reasoning
>> in the patch description.  Providing a link to slides is fine, but
>> your commit message needs to convey the important information and I
>> don't think that is the case here (what happens when that URL dies?).
>
> Do you need an explicit reminder there that the function ?kmalloc? provides its own
> error reporting already because the flag ?__GFP_NOWARN? was not passed here?

That is what I said by "better reasoning in the patch description",
however, now that I'm looking at this again, I don't think I'm going
to merge this.  Yes, maybe in some cases it is a bit wasteful, but I
like the error message.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
