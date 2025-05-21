Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA561C84BC;
	Wed, 21 May 2025 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841266; cv=none; b=ZrFk6CYwPDksEtyyD7YxK7FUIrgbObLJ4Cf5c/5RlMgRCsDSmE+HmY890T5NKZNLdfT9UTZJ2ZPBTdeaCkAJv5j23kpPebS3JoIuVVH0gGKnskBCwwirB3aj/rq0MkVlvi8DzmM/pwqoHlVqkOOFgLbJ87zg99IC/VsPEfVrsXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841266; c=relaxed/simple;
	bh=oi+Q5ewj5nvjv2ZTao8kqiOb+iBzQ0KR23F9dW4V2H0=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=fiqeu0wGHqipaRG54EGYzXE6A34WfZEEOZK+Cz9alIKen+ZGvwKL284Gwoui9FAvpycAPUXDF/2N76RrfEYyTS0o7EMCFwqhtmkl2+VPsWwb4hmQxAFKZ63AXK9lF57Fuub3SeAmbk4TZM6hrArxjlcjMafQLu2Je/N1Bhh9evg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:51378)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uHlM5-006wE8-MP; Wed, 21 May 2025 09:27:41 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:41852 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uHlM4-00F9XJ-7J; Wed, 21 May 2025 09:27:41 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jann Horn <jannh@google.com>
Cc: Richard Guy Briggs <rgb@redhat.com>,  "Serge E. Hallyn"
 <serge@hallyn.com>,  Kees Cook <kees@kernel.org>,  Max Kellermann
 <max.kellermann@ionos.com>,  paul@paul-moore.com,  jmorris@namei.org,
  Andy Lutomirski <luto@kernel.org>,  morgan@kernel.org,  Christian Brauner
 <christian@brauner.io>,  linux-security-module@vger.kernel.org,
  linux-kernel@vger.kernel.org
References: <20250306082615.174777-1-max.kellermann@ionos.com>
	<878qmxsuy8.fsf@email.froward.int.ebiederm.org>
	<202505151451.638C22B@keescook>
	<87ecwopofp.fsf@email.froward.int.ebiederm.org>
	<CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
	<87wmagnnhq.fsf@email.froward.int.ebiederm.org>
	<202505201319.D57FDCB2A@keescook>
	<87frgznd74.fsf_-_@email.froward.int.ebiederm.org>
	<CAG48ez0N_1CEKyMHdjnvwsxUkCenmzsLe7dkUL=a6OmU4tPa6Q@mail.gmail.com>
Date: Wed, 21 May 2025 10:27:32 -0500
In-Reply-To: <CAG48ez0N_1CEKyMHdjnvwsxUkCenmzsLe7dkUL=a6OmU4tPa6Q@mail.gmail.com>
	(Jann Horn's message of "Wed, 21 May 2025 01:53:29 +0200")
Message-ID: <87zff6gf17.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1uHlM4-00F9XJ-7J;;;mid=<87zff6gf17.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19L44tg4Qm5VYcQSeGWBEThcmHH/PASd9k=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.2757]
	*  0.7 XMSubLong Long Subject
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XMGenDplmaNmb Diploma spam phrases+possible phone number
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 891 ms - load_scoreonly_sql: 0.10 (0.0%),
	signal_user_changed: 10 (1.1%), b_tie_ro: 9 (1.0%), parse: 1.21 (0.1%),
	 extract_message_metadata: 13 (1.5%), get_uri_detail_list: 2.1 (0.2%),
	tests_pri_-2000: 24 (2.7%), tests_pri_-1000: 6 (0.7%), tests_pri_-950:
	2.7 (0.3%), tests_pri_-900: 2.1 (0.2%), tests_pri_-90: 198 (22.2%),
	check_bayes: 196 (22.0%), b_tokenize: 10 (1.1%), b_tok_get_all: 9
	(1.0%), b_comp_prob: 3.5 (0.4%), b_tok_touch_all: 169 (18.9%),
	b_finish: 1.16 (0.1%), tests_pri_0: 607 (68.1%), check_dkim_signature:
	1.43 (0.2%), check_dkim_adsp: 4.5 (0.5%), poll_dns_idle: 0.64 (0.1%),
	tests_pri_10: 2.9 (0.3%), tests_pri_500: 19 (2.2%), rewrite_mail: 0.00
	(0.0%)
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, christian@brauner.io, morgan@kernel.org, luto@kernel.org, jmorris@namei.org, paul@paul-moore.com, max.kellermann@ionos.com, kees@kernel.org, serge@hallyn.com, rgb@redhat.com, jannh@google.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Jann Horn <jannh@google.com> writes:

> On Wed, May 21, 2025 at 12:13=E2=80=AFAM Eric W. Biederman
> <ebiederm@xmission.com> wrote:

> Looks good to me overall, thanks for figuring out the history of this
> not-particularly-easy-to-understand code and figuring out the right
> fix.
>
> Reviewed-by: Jann Horn <jannh@google.com>
>
>> @@ -917,7 +911,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *bp=
rm, const struct file *file)
>>         /* Process setpcap binaries and capabilities for uid 0 */
>>         const struct cred *old =3D current_cred();
>>         struct cred *new =3D bprm->cred;
>> -       bool effective =3D false, has_fcap =3D false, is_setid;
>> +       bool effective =3D false, has_fcap =3D false, id_changed;
>>         int ret;
>>         kuid_t root_uid;
>>
>> @@ -941,9 +935,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *bp=
rm, const struct file *file)
>>          *
>>          * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
>>          */
>> -       is_setid =3D __is_setuid(new, old) || __is_setgid(new, old);
>> +       id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(new-=
>egid);
>
> Hm, so when we change from one EGID to another EGID which was already
> in our groups list, we don't treat it as a privileged exec? Which is
> okay because, while an unprivileged user would not just be allowed to
> change their EGID to a GID from their groups list themselves through
> __sys_setregid(), they would be allowed to create a new setgid binary
> owned by a group from their groups list and then execute that?
>
> That's fine with me, though it seems a little weird to me. setgid exec
> is changing our creds and yet we're not treating it as a "real" setgid
> execution because the execution is only granting privileges that
> userspace could have gotten anyway.

More than could have gotten.  From permission checking point of view
permission that the application already had.  In general group based
permission checks just check in_group_p, which looks at cred->fsgid and
the group.

The logic is since the effective permissions of the running executable
have not changed, there is nothing to special case.

Arguably a setgid exec can drop what was egid, and if people have
configured their permissions to deny people access based upon a group
they are in that could change the result of the permission checks.  If
changing egid winds up dropping a group from the list of the process's
groups, the process could also have dropped that group with setresgid.
So I don't think we need to be concerned about the combination of
dropping egid and brpm->unsafe.

If anyone sees a hole in that logic I am happy to change the check
to !gid_eq(new->egid, old->egid), but I just can't see a way changing
egid/fsgid to a group the process already has is a problem.

>> -       if ((is_setid || __cap_gained(permitted, new, old)) &&
>> +       if ((id_changed || __cap_gained(permitted, new, old)) &&
>>             ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
>>              !ptracer_capable(current, new->user_ns))) {
>>                 /* downgrade; they get no more than they had, and maybe =
less */

Eric
