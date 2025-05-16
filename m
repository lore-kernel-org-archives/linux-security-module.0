Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF30F323D;
	Fri, 16 May 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409216; cv=none; b=Jyor0sGbnzwlxm+ZUwU+Wtgc0rBK5xOkgvBLLj2or8iqlJjmVrdrbjPfuDGBKkCuWfja1IxlzQH2Wlmi1jcNbS7+RHyJwI++xRe9/+TXR4FTgEd1TFqcDkAVq0pDH1Au5V1EBQWElT3LfpGHYNYJzFdLnjwYCFE/E6iQu+eXF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409216; c=relaxed/simple;
	bh=GE12mxkVepcjr70w4w9PunRSxhc8t9dXQi4J2IiNVU0=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=GzjOFqBXsQTL9oYA5nbbnlhYUOQ08Df2+WDGX8stj7D3TZ8IykqgvQ6d9N8E9Cr+TaTNA6BpwwxKof4rtoyT1gmUu6NkM4kVhNjoDSKkALApmpCKlt0USOtNhtu+fGgX7ZqfvnqiQ6M15aZKbVOQqzj/oLdGe9DydeyZ0Il66oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:52250)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uFwxT-00AVEJ-58; Fri, 16 May 2025 09:26:47 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:43216 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uFwxR-004r12-St; Fri, 16 May 2025 09:26:46 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kees Cook <kees@kernel.org>
Cc: Max Kellermann <max.kellermann@ionos.com>,  "Serge E. Hallyn"
 <serge@hallyn.com>,  paul@paul-moore.com,  jmorris@namei.org,  Andy
 Lutomirski <luto@kernel.org>,  morgan@kernel.org,  Christian Brauner
 <christian@brauner.io>,  Jann Horn <jannh@google.com>,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
References: <20250306082615.174777-1-max.kellermann@ionos.com>
	<878qmxsuy8.fsf@email.froward.int.ebiederm.org>
	<202505151451.638C22B@keescook>
Date: Fri, 16 May 2025 10:26:02 -0500
In-Reply-To: <202505151451.638C22B@keescook> (Kees Cook's message of "Thu, 15
	May 2025 15:09:48 -0700")
Message-ID: <87ecwopofp.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uFwxR-004r12-St;;;mid=<87ecwopofp.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18aC6uDo0YWOLeAg/L95AcRjDh8qgc6tk0=
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Kees Cook <kees@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 523 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 17 (3.2%), b_tie_ro: 15 (2.8%), parse: 1.06
	(0.2%), extract_message_metadata: 4.6 (0.9%), get_uri_detail_list: 2.0
	(0.4%), tests_pri_-2000: 3.2 (0.6%), tests_pri_-1000: 2.4 (0.5%),
	tests_pri_-950: 1.41 (0.3%), tests_pri_-900: 1.22 (0.2%),
	tests_pri_-90: 82 (15.7%), check_bayes: 80 (15.2%), b_tokenize: 8
	(1.6%), b_tok_get_all: 11 (2.0%), b_comp_prob: 3.5 (0.7%),
	b_tok_touch_all: 52 (9.9%), b_finish: 1.33 (0.3%), tests_pri_0: 387
	(73.9%), check_dkim_signature: 1.12 (0.2%), check_dkim_adsp: 3.1
	(0.6%), poll_dns_idle: 1.27 (0.2%), tests_pri_10: 4.1 (0.8%),
	tests_pri_500: 9 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec: Correct the permission check for unsafe exec
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, jannh@google.com, christian@brauner.io, morgan@kernel.org, luto@kernel.org, jmorris@namei.org, paul@paul-moore.com, serge@hallyn.com, max.kellermann@ionos.com, kees@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Kees Cook <kees@kernel.org> writes:

> On Thu, May 15, 2025 at 11:24:47AM -0500, Eric W. Biederman wrote:
>> I have condensed the logic from Linux-2.4.0-test12 to just:
>> 	id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
>> 
>> This change is userspace visible, but I don't expect anyone to care.
>> [...]
>> -static inline bool __is_setuid(struct cred *new, const struct cred *old)
>> -{ return !uid_eq(new->euid, old->uid); }
>> -
>> -static inline bool __is_setgid(struct cred *new, const struct cred *old)
>> -{ return !gid_eq(new->egid, old->gid); }
>> -
>> [...]
>> -	is_setid = __is_setuid(new, old) || __is_setgid(new, old);
>> +	id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
>
> The core change here is testing for differing euid rather than
> mismatched uid/euid. (And checking for egid in the set of all groups.)

Yes.

For what the code is trying to do I can't fathom what was trying to
be accomplished by the "mismatched" uid/euid check.

> Imagined situations:
>
> - setuid process is sharing fs. We already believe this is a non-issue,
>   as Jann pointed out about Chrome's order of operations, so so changes
>   here are likely fine.

Yes, nothing has changed from a security standpoint.

> - somehow ptracing a process with uid!=euid, and it tries to exec a
>   different setuid==euid ELF. Is switching ELF images a security
>   boundary? Probably not realistically.

The concern with tracing is can the tracer gain more privileges from
the traced application.  If there is no switch of euid or egid the
answer is no.

In fact what we do is actively bad in the ptrace case as it makes
debugging unnecessarily change the behavior of an application.

> - setuid process sets NNP and execs a setuid==euid ELF, expecting to
>   have euid stripped. That doesn't happen any more. This is the most
>   worrisome case, but a program like that should _really_ have dropped
>   euid first if it is depending on that behavior. Hmmm. Probably some
>   code searching is needed...

That is a fair question.  Has some no-new-privs using application
that has uid != euid when it calls exec developed a dependency on
how we the code sets euid == uid when we call exec today.

That is exactly the case that Max Kellermann has a problem with,
so we have at least one no-new-privs user that wants the fixed behavior.

In addition to code searching we could first change the behavior for
everything except ptrace to just return -EPERM.  That should flush out
most of the users of this case if we miss some one.

Given that I have only seen a justification for limping along during
ptrace from Linus (and it was a long time ago) I think we would be
better off just making it fail, and then we don't have to worry
about userspace depending upon this weird case in future maintenance.

Eric

