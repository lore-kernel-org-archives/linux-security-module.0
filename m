Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828E2309A3;
	Fri,  9 May 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801925; cv=none; b=SMJNb6pBqciwrDs8vtkmbXli0cm4/F86519rUV1feZXCdeGwSwsorye12m7a6LMtX+1PCwNytK98yDG1IOMXqxm50XBUo0cy3XLzixpMAByo99XreUuGw+4AoCaQY5Gn+Ox11ct9JCi2er+aARFkovijTG/0Wg3SCiXtz7/oBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801925; c=relaxed/simple;
	bh=Yd8W1GtKAevzypSOVCZqbNt712iYf1AsnUrAZDXEq1E=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=U8IAUATSPI87+DlKmivScUWXZ9czSmM307dhYczWT3v8NMJyYD2pSyIywKjKF/VtGakHDuU4SsEM0EOxJFX9rWvz9i9MzOSmYxMXqJu+FgaDLQLmRJvuJJUTo4g0gZW/IL/KJrAw76p74JEMRpMiI00j5+DP8T8DstVTy54q0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:35438)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uDOyR-00AAB3-D6; Fri, 09 May 2025 08:45:15 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:48940 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uDOyQ-00DyBc-D7; Fri, 09 May 2025 08:45:15 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: sergeh@kernel.org,  "Serge E. Hallyn" <serge@hallyn.com>,  Andy
 Lutomirski <luto@kernel.org>,  paul@paul-moore.com,  jmorris@namei.org,
  kees@kernel.org,  morgan@kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
References: <20250306082615.174777-1-max.kellermann@ionos.com>
	<20250309151907.GA178120@mail.hallyn.com>
	<CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>
	<20250506132158.GA682102@mail.hallyn.com>
	<CAKPOu+9JCLVpJ-g_0WwLm5oy=9sq=c9rmoAJD6kNatpMZbbw9w@mail.gmail.com>
	<aB0sVcjFZaCVEirH@lei>
	<CAKPOu+89=+SFk1hKGLheMtPq+K47E9FRCo1DBQo9zGMwW=Tr2w@mail.gmail.com>
Date: Fri, 09 May 2025 09:44:40 -0500
In-Reply-To: <CAKPOu+89=+SFk1hKGLheMtPq+K47E9FRCo1DBQo9zGMwW=Tr2w@mail.gmail.com>
	(Max Kellermann's message of "Fri, 9 May 2025 08:15:33 +0200")
Message-ID: <87h61t7siv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1uDOyQ-00DyBc-D7;;;mid=<87h61t7siv.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+YlNgXKRuproaqAKxc1t7PkLnIckmGWjU=
X-Spam-Level: ***
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4992]
	*  0.7 XMSubLong Long Subject
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  1.5 TR_AI_Phishing Email matches multiple AI-related patterns
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Max Kellermann <max.kellermann@ionos.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 489 ms - load_scoreonly_sql: 0.26 (0.1%),
	signal_user_changed: 13 (2.6%), b_tie_ro: 11 (2.2%), parse: 1.08
	(0.2%), extract_message_metadata: 19 (3.9%), get_uri_detail_list: 1.39
	(0.3%), tests_pri_-2000: 17 (3.5%), tests_pri_-1000: 2.9 (0.6%),
	tests_pri_-950: 1.29 (0.3%), tests_pri_-900: 1.07 (0.2%),
	tests_pri_-90: 56 (11.5%), check_bayes: 55 (11.2%), b_tokenize: 7
	(1.5%), b_tok_get_all: 8 (1.5%), b_comp_prob: 2.7 (0.6%),
	b_tok_touch_all: 33 (6.7%), b_finish: 1.15 (0.2%), tests_pri_0: 360
	(73.7%), check_dkim_signature: 1.18 (0.2%), check_dkim_adsp: 3.0
	(0.6%), poll_dns_idle: 0.45 (0.1%), tests_pri_10: 2.3 (0.5%),
	tests_pri_500: 10 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are
 identical
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, morgan@kernel.org, kees@kernel.org, jmorris@namei.org, paul@paul-moore.com, luto@kernel.org, serge@hallyn.com, sergeh@kernel.org, max.kellermann@ionos.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Max Kellermann <max.kellermann@ionos.com> writes:

> On Fri, May 9, 2025 at 12:12=E2=80=AFAM <sergeh@kernel.org> wrote:
>> ABI stability is about the most important thing to Linus, so yes, if
>> documentation and code disagree, then we should fix the documentation,
>> except in the case where the current behavior just really is wrong
>> or insecure.
>
> It is insecure indeed (can be abused for LD_PRELOAD
> attacks):https://lore.kernel.org/lkml/CAKPOu+8+1uVrDJHwmHJd2d46-N6AwjR4_b=
btoSJS+sx6J=3Drkjg@mail.gmail.com/

I don't understand what you are trying to solve,
but the patch at the top of the thread introduces a
has_identical_uids_gids and is pure nonsense.

In particular __is_setuid or __is_setgid being true guarantees
that has_identical_uids_gids will be false.

Which means has_identical_uids_gids adds nothing, and the patch is
pointless.



If your concern is LD_PRELOAD and the like please don't play with
the uids/gids and instead just make certain bprm->secureexec gets
set.



At this point I am pretty certain that changing the logic and leaving
extra uids/gids set will result in security vulnerabilities for someone
who actually depends upon how the code works today.  I see no evidence
in this conversation that anyone has surveyed the users of NO_NEW_PRIVS
and verified how anyone actually uses it.  Without such evidence we
have to assume that userspace depends upon the current behavior.

Eric

