From: paul@paul-moore.com (Paul Moore)
Date: Fri, 2 Jun 2017 15:30:01 -0400
Subject: [RFC PATCH V2 0/4] capabilities: do not audit log BPRM_FCAPS on
	set*id
In-Reply-To: <20170602180356.GC6203@madcap2.tricolour.ca>
References: <cover.1494527628.git.rgb@redhat.com>
	<CAHC9VhRcxvxQjo3ZRcNaGjoKaqBe-CfbypY9aYzetZYXWTAyLA@mail.gmail.com>
	<20170602180356.GC6203@madcap2.tricolour.ca>
Message-ID: <CAHC9VhQ_G82fE++RySOK3OgW9y59=HsisRWB=zk2ZP7J_D-NEw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 2, 2017 at 2:03 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2017-06-02 11:19, Paul Moore wrote:
>> On Thu, May 11, 2017 at 4:42 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > The audit subsystem is adding a BPRM_FCAPS record when auditing setuid
>> > application execution (SYSCALL execve). This is not expected as it was
>> > supposed to be limited to when the file system actually had capabilities
>> > in an extended attribute.  It lists all capabilities making the event
>> > really ugly to parse what is happening.  The PATH record correctly
>> > records the setuid bit and owner.  Suppress the BPRM_FCAPS record on
>> > set*id.
>> >
>> > See: https://github.com/linux-audit/audit-kernel/issues/16
>> >
>> > The patch that resolves this issue is the third.  The first and second just
>> > massage the logic to make it easier to understand.
>> >
>> > It would be possible to address the original issue with a change of
>> >         "!uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid)"
>> > to
>> >         "!(uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid))"
>> > but it took me long enough to understand this logic that I don't think I'd be
>> > doing any favours by leaving it this difficult to understand.
>> >
>> > The final patch attempts to address all the conditions that need logging based
>> > on mailing list conversations, recoginizing there is probably some duplication
>> > in the logic, which is why I'm posting this as an RFC for some feedback.
>> >
>> > Richard Guy Briggs (4):
>> >   capabilities: use macros to make the logic easier to follow and
>> >     verify
>> >   capabilities: invert logic for clarity
>> >   capabilities: fix logic for effective root or real root
>> >   capabilities: auit log other surprising conditions
>> >
>> >  security/commoncap.c |   55 ++++++++++++++++++++++++++++++++-----------------
>> >  1 files changed, 36 insertions(+), 19 deletions(-)
>>
>> Following up on this set of patches ... I see there was some
>> discussion between you and Serge for one of the patches, but it isn't
>> clear to me that there was any resolution reached; where do things
>> stand at the moment?
>
> Well, I was still waiting to hear from you before submitting another
> round of patches.

All of the changes in this patchset relate to the capabilities code
and not the audit code so I don't really have a strong opinion.  Serge
knows way more about the subtleties of Linux capabilities than I do; I
trust his judgement there.

The only area I might want to weigh in on would be if/when we generate
records, but considering the rather vague answer from Steve when he
was asked about certification requirements, I'm not going to worry
about it too much right now.  Your logic outlined in the description
seems reasonable.

> I'd like to replace the macros with local variables (rather than
> funcitons), expecting that the compiler would be smarter than me and
> figure out the best way to do things.

Since that lives in the capabilities code and not the audit code that
is between you and Serge as far as I'm concerned.  I can send this up
via the audit tree if Serge would prefer, but I would want to see his
ACK.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
