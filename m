Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F40149DE8;
	Fri, 13 Jun 2025 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827305; cv=none; b=ljrQsn3CMxZQmnuda7/evhKom97yWZiptQgXC8bKb17qPHEHVYImI3nXgr+m+RFHf8rTvPE93iyS1mnhzFa02J7pzjvP/JshDY0gdNWChXGK9uJB0YXuUZ651LSIewAQA34TUovYdF9CkDem9vm/H+e77Z45We+xzhFbWSP3s1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827305; c=relaxed/simple;
	bh=vnWsm4LRUsXGvvlcvq/aWEudAYhnE6+wMQQnlbygm8o=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=swzJ6zO4ZxoQLkc/bQfQyEShBSoLp7rMU33yXVX4DwJtKLh5OAwo5n4/uQ/hp0ULDO0wDt8/J9hz6tJF3sofdENoEQiDBh9xhUVIdghsuPmrNxvoYnAt7xfXPGSxw9fohgnFSbdjvIZJgESV6gssZ2nz8K/AInSZT7KKywY8sEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:58800)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uQ60r-00DYaa-Ow; Fri, 13 Jun 2025 09:08:13 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:44690 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uQ60q-00A6I1-O7; Fri, 13 Jun 2025 09:08:13 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Paul Moore <paul@paul-moore.com>,  Jann Horn <jannh@google.com>,
  Richard Guy Briggs <rgb@redhat.com>,  "Serge E. Hallyn"
 <serge@hallyn.com>,  Kees Cook <kees@kernel.org>,  jmorris@namei.org,
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
	<87zff6gf17.fsf@email.froward.int.ebiederm.org>
	<CAG48ez1z97sCsx53W0O_dCCJL6tnf2pWuv=qaeszcYBfz_01sA@mail.gmail.com>
	<CAHC9VhRPUXwqLvo4rbxL0++5zqHXfD8_tr-sirTJXdF_Aba_UQ@mail.gmail.com>
	<CAKPOu+-S5C59X8zW=6keYAsHecketOBzMbb3XXDnLTc0X1nBhA@mail.gmail.com>
Date: Fri, 13 Jun 2025 10:07:44 -0500
In-Reply-To: <CAKPOu+-S5C59X8zW=6keYAsHecketOBzMbb3XXDnLTc0X1nBhA@mail.gmail.com>
	(Max Kellermann's message of "Wed, 11 Jun 2025 16:23:56 +0200")
Message-ID: <87jz5fbry7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1uQ60q-00A6I1-O7;;;mid=<87jz5fbry7.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19DS5hI3QZXTnlYT7NATr6IQyCR/t/vFwc=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4714]
	*  0.7 XMSubLong Long Subject
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Max Kellermann <max.kellermann@ionos.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 550 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.3 (0.8%), b_tie_ro: 2.9 (0.5%), parse: 1.29
	(0.2%), extract_message_metadata: 15 (2.6%), get_uri_detail_list: 2.4
	(0.4%), tests_pri_-2000: 5 (0.9%), tests_pri_-1000: 2.1 (0.4%),
	tests_pri_-950: 1.02 (0.2%), tests_pri_-900: 0.79 (0.1%),
	tests_pri_-90: 55 (9.9%), check_bayes: 53 (9.7%), b_tokenize: 6 (1.2%),
	 b_tok_get_all: 8 (1.5%), b_comp_prob: 2.7 (0.5%), b_tok_touch_all: 33
	(6.0%), b_finish: 0.69 (0.1%), tests_pri_0: 454 (82.6%),
	check_dkim_signature: 0.44 (0.1%), check_dkim_adsp: 13 (2.4%),
	poll_dns_idle: 0.38 (0.1%), tests_pri_10: 2.3 (0.4%), tests_pri_500: 7
	(1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, christian@brauner.io, morgan@kernel.org, luto@kernel.org, jmorris@namei.org, kees@kernel.org, serge@hallyn.com, rgb@redhat.com, jannh@google.com, paul@paul-moore.com, max.kellermann@ionos.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Max Kellermann <max.kellermann@ionos.com> writes:

> On Wed, Jun 11, 2025 at 2:19=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
>> Aside from a tested-by verification from Max, it looks like everyone
>> is satisfied with the v2 patch, yes?
>
> Sorry for the delay. I tested Eric's v2 patch and it solves my
> problem. His patch is nearly identical to mine, it's only a bit more
> intrusive by removing the weird __is_setXid functions that never made
> sense. I welcome that; I wasn't confident enough to do that and tried
> to make the least intrusive patch.
>
> Eric, I'm glad you changed your mind and no longer consider my work
> "pure nonsense" and "pointless".

As you pointed out in that case my analysis of your code was incorrect.

Further I wrote this patch when I finally realized what is going on and
that the case you are dealing with is an actual bug in the current
code and not some kind of enhancement or extension.

> But one problem remains: in the same email, you demanded evidence that
> userspace doesn't depend on the current behavior. However, in your
> patch description, you hand-waved that away by "I don't expect anyone
> to care". What happened to that?


The analysis of __is_setuid and __is_setgid that allowed me to remove
them helped quite a lot.

The analysis makes it clear that the code change is semantically safe
so we don't loose anything by not mucking with permissions.

The analysis shows the code is good comprehension and maintenance and
not just for your case.  It also makes it clear why not supporting your
case is a bug, and frankly a regression in the current code. (A 20 year
old regression so that doesn't carry much weight but still a
regression).

A related analysis in another parallel thread mostly concluded that for
brpm->unsafe in general it is a better user experience to terminate the
exec with a permission error instead of continuing the exec.  Exception
ptrace.

Part of my resistance was the initial reading that your change was
trying to escape the unsafe downgrading of permissions, instead of
showing that it was safe to keep the permissions.

With the reminder that no one should even be exercising the permission
downgrading case, it became clear that changing the little bit that is
safe should not affect may users at all.

Failing the exec rather than downgrading permissions will also make
a good test to see if anyone cares about this functionality.  I do still
believe we should tread carefully.

Hopefully that makes things clear.

Eric

