Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A3280329;
	Fri, 16 May 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438204; cv=none; b=UdNCOABTaxhVFmp6RstozThlFVEb0OHn0l1It6ft7qkO94roDaAObwCMeCoVKGBWEKenaXy1G8X/bTkfu1QPJnfEglr1FZUMSldcdiXrrLAioqk63LyH5CTjfCArw9KWjXVx0PYoBumrIJN/dMc+Zg70XCwJFYrzVrMTJ9b5kMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438204; c=relaxed/simple;
	bh=H/KF15FWESax3Ami7aw52ivPalCvmvYWr/JCCdYLAUs=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=b03j4wVsjrdpljNHiU0IwL/wTlQpHjtxYtqWzfUXTPszWoQP+yUntBWMMflKQs7yOHOWV+OYmpsVh6M/nfUrL+SCU2vE6j6rMokgys+XkPUHJSpYz6yboG05kqYbJaKDfiHPVUlZyyC9mWzGB8a9PLq6T9Yw7NavuKzNHf3z6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:50176)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uG4V5-00B86O-NK; Fri, 16 May 2025 17:29:59 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:60242 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uG4V4-005hfZ-H4; Fri, 16 May 2025 17:29:59 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>,  Max Kellermann <max.kellermann@ionos.com>,
  "Serge E. Hallyn" <serge@hallyn.com>,  paul@paul-moore.com,
  jmorris@namei.org,  Andy Lutomirski <luto@kernel.org>,
  morgan@kernel.org,  Christian Brauner <christian@brauner.io>,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
References: <20250306082615.174777-1-max.kellermann@ionos.com>
	<878qmxsuy8.fsf@email.froward.int.ebiederm.org>
	<202505151451.638C22B@keescook>
	<87ecwopofp.fsf@email.froward.int.ebiederm.org>
	<CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
Date: Fri, 16 May 2025 18:29:21 -0500
In-Reply-To: <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
	(Jann Horn's message of "Fri, 16 May 2025 20:06:15 +0200")
Message-ID: <87wmagnnhq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1uG4V4-005hfZ-H4;;;mid=<87wmagnnhq.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18KHP4G2k129u48C3k8aJHO0B3C2SMDeCY=
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4918]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 626 ms - load_scoreonly_sql: 0.26 (0.0%),
	signal_user_changed: 12 (1.9%), b_tie_ro: 10 (1.6%), parse: 1.06
	(0.2%), extract_message_metadata: 13 (2.1%), get_uri_detail_list: 2.3
	(0.4%), tests_pri_-2000: 13 (2.1%), tests_pri_-1000: 2.7 (0.4%),
	tests_pri_-950: 1.34 (0.2%), tests_pri_-900: 1.12 (0.2%),
	tests_pri_-90: 105 (16.8%), check_bayes: 104 (16.5%), b_tokenize: 9
	(1.4%), b_tok_get_all: 9 (1.5%), b_comp_prob: 3.0 (0.5%),
	b_tok_touch_all: 79 (12.6%), b_finish: 0.95 (0.2%), tests_pri_0: 462
	(73.8%), check_dkim_signature: 0.62 (0.1%), check_dkim_adsp: 3.0
	(0.5%), poll_dns_idle: 1.07 (0.2%), tests_pri_10: 2.5 (0.4%),
	tests_pri_500: 8 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec: Correct the permission check for unsafe exec
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, christian@brauner.io, morgan@kernel.org, luto@kernel.org, jmorris@namei.org, paul@paul-moore.com, serge@hallyn.com, max.kellermann@ionos.com, kees@kernel.org, jannh@google.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Jann Horn <jannh@google.com> writes:

> On Fri, May 16, 2025 at 5:26=E2=80=AFPM Eric W. Biederman <ebiederm@xmiss=
ion.com> wrote:
>> Kees Cook <kees@kernel.org> writes:
>>
>> > On Thu, May 15, 2025 at 11:24:47AM -0500, Eric W. Biederman wrote:
>> >> I have condensed the logic from Linux-2.4.0-test12 to just:
>> >>      id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(new-=
>egid);
>> >>
>> >> This change is userspace visible, but I don't expect anyone to care.
>> >> [...]
>> >> -static inline bool __is_setuid(struct cred *new, const struct cred *=
old)
>> >> -{ return !uid_eq(new->euid, old->uid); }
>> >> -
>> >> -static inline bool __is_setgid(struct cred *new, const struct cred *=
old)
>> >> -{ return !gid_eq(new->egid, old->gid); }
>> >> -
>> >> [...]
>> >> -    is_setid =3D __is_setuid(new, old) || __is_setgid(new, old);
>> >> +    id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(new-=
>egid);
>> >
>> > The core change here is testing for differing euid rather than
>> > mismatched uid/euid. (And checking for egid in the set of all groups.)
>>
>> Yes.
>>
>> For what the code is trying to do I can't fathom what was trying to
>> be accomplished by the "mismatched" uid/euid check.
>
> I remember that when I was looking at this code years ago, one case I
> was interested in was what happens when a setuid process (running with
> something like euid=3D1000,ruid=3D0) execve()'s a normal binary. Clearly
> the LSM_UNSAFE_* stuff is not so interesting there, because we're
> already coming from a privileged context; but the behavior of
> bprm->secureexec could be important.
>
> Like, I think currently a setuid binary like this is probably (?) not
> exploitable:
>
> int main(void) {
>   execl("/bin/echo", "echo", "hello world");
> }
>
> but after your proposed change, I think it might (?) become
> exploitable because "echo" would not have AT_SECURE set (I think?) and
> would therefore load libraries based on environment variables?

Yes.  bprm->secureexec controls AT_SECURE.

I am fine if we want to set secureexec and AT_SECURE in this situation.
It is a bit odd, but I don't see a problem with that.

> To be clear, I think this would be a stupid thing for userspace to do
> - a setuid binary just should not be running other binaries with the
> caller-provided environment while having elevated privileges. But if
> userspace was doing something like that, this change might make it
> more exploitable, and I imagine that the check for mismatched uid/euid
> was intended to catch cases like this?

The patch that made the change doesn't show up on lore.kernel.org so I
believe any record of the rational is lost.

To me it looks like someone was right up against the deadline to get
their code change into 2.4.0, was used to uid !=3D euid in userspace, and
talked Linus into a last minute merge before 2.4.0 was released.

Eric
