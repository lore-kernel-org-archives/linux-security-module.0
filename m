From: jannh@google.com (Jann Horn)
Date: Mon, 6 Aug 2018 21:47:02 +0200
Subject: [PATCH] selinux: stricter parsing in mls_context_to_sid()
In-Reply-To: <CAHC9VhT83LuwuGB4ndVpkqtfLZ2Se1Qqhw57CTEZ-5bzPATiag@mail.gmail.com>
References: <20180803093604.38254-1-jannh@google.com>
	<CAHC9VhT83LuwuGB4ndVpkqtfLZ2Se1Qqhw57CTEZ-5bzPATiag@mail.gmail.com>
Message-ID: <CAG48ez0UPrDQ1t=3gWB3ahj3ksc1_FAC0T6-y2ngi6tLTpUUxg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Aug 4, 2018 at 2:01 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Aug 3, 2018 at 5:36 AM Jann Horn <jannh@google.com> wrote:
> >
> > mls_context_to_sid incorrectly accepted MLS context strings that are
> > followed by a dash and trailing garbage.
> >
> > Before this change, the following command works:
> >
> > # mount -t tmpfs -o 'context=system_u:object_r:tmp_t:s0-s0:c0-BLAH' \
> > none mount
> >
> > After this change, it fails with the following error message in dmesg:
> >
> > SELinux: security_context_str_to_sid(system_u:object_r:tmp_t:s0-s0:c0-BLAH)
> > failed for (dev tmpfs, type tmpfs) errno=-22
> >
> > This is not an important bug; but it is a small quirk that was useful for
> > exploiting a vulnerability in fusermount.
> >
> > This patch does not change the behavior when the policy does not have MLS
> > enabled.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  security/selinux/ss/mls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Ooof.  mls_context_to_sid() isn't exactly the most elegant function is
> it?  I suppose some of that is due to the label format, but it still
> seems like we can do better.  However, before I jump into that let me
> say that speaking strictly about your patch, yes, it does look correct
> to me.
>
> What I'm wonder is if we rework/reorder some of the parser to remove
> some of the ordering specific (e.g. "l == 0") and reduce some
> redundancy ... be patient with me for a moment ...
>
> The while loops immediately following the "Extract low sensitivity"
> and "Extract high sensitivity" comments are basically the same,
> including NULL'ing the delimiter if necessary, the only difference is
> the additional '-' delimiter in the low sensitivity search.
>
> The only *legal* place for a '-' in the MLS portion of the label is to
> separate the low/high portions.
>
> What if we were to do a quick search for the low/high separator before
> extracting the low sensitivity and stored low/high pointers for later
> use?  e.g.
>
>   rangep[0] = *scontext;
>   rangep[1] = strchr(rangep[0], '-');
>   if (rangep[1])
>     rangep[1]++ = '\0';
>
> ... we could then move the "Extract X sensitivity" into the main for
> loop as well remove all of the '-' special case parsing checks, e.g.
>
>   for (l = 0; l < 2; l++) {
>
>     scontextp = rangep[l];
>     if (!scontextp)
>       break;
>
>     while (*p && *p != ':')
>       p++;
>     delim = *p;
>     if (delim != '\0')
>       *p++ = '\0';
>
>     /* extract the level (use existing code) */
>
>     /* extract the category set, if present (use existing code) */
>
>     /* no need to worry about the '-' delimiter */
>
>   }
>
> I *believe* that should work.  I think.  Does that make sense?

I'm fiddling with the code a bit now - your suggestion sounds good to
me, and I think there are a couple other small tweaks that can make
the code more readable. I hope I'll have a patch ready soon.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
