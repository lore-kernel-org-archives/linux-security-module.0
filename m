Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4432914;
	Fri, 29 Nov 2024 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854245; cv=none; b=fcbfs7Y6WmMz31PSivzdFWuWufAS/cJlen0qOt9JNV1PvcaOGqpsSe0qZKal+OjNAumkqjKLGKnwsfWDOFK+bwy1FRjYxDITNl4zwZI2Zoy0eR44XvMgkquK+Z7aBSRwxquhl5sLC/B32+8nwl9B7R0p9oTP0KGECiDqVnuR1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854245; c=relaxed/simple;
	bh=VIIOJWLcq42/oGQuTy22sIrkrMe4MdfBULso45Tqik4=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=adGhdXuJRJN0EneeT95vqZouzu7wLnhpG+EMtIPk5Rmqvz9RDLv4tPx74qcw6KVb3hW9d/O9k0aDCp5mXEW0YTupELJUzCYP1XPKqfC09dY3kPWnI/g1utzytngtB/H3KkjdcWcU1sZJgIRcqI0quPI20rGrYEJOIAZmnQXbzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:39730)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tGsXr-005YHH-2J; Thu, 28 Nov 2024 21:23:55 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:50162 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tGsXp-009XyY-N9; Thu, 28 Nov 2024 21:23:54 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Kees Cook
 <kees@kernel.org>,  linux-kernel@vger.kernel.org,  Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>,  Nir Lichtman <nir@lichtman.org>,  Tycho
 Andersen <tandersen@netflix.com>,  Vegard Nossum
 <vegard.nossum@oracle.com>, linux-security-module@vger.kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>
References: <202411210651.CD8B5A3B98@keescook>
	<CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
	<05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org>
	<CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
	<202411271645.04C3508@keescook>
	<CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
	<20241128020558.GF3387508@ZenIV>
	<CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
	<13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org>
	<CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
	<20241129033419.GI3387508@ZenIV>
Date: Thu, 28 Nov 2024 22:23:18 -0600
In-Reply-To: <20241129033419.GI3387508@ZenIV> (Al Viro's message of "Fri, 29
	Nov 2024 03:34:19 +0000")
Message-ID: <87h67qoeh5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tGsXp-009XyY-N9;;;mid=<87h67qoeh5.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/kDxxtqD/RD4hbP6ZFSoFAob7QKt0QrJI=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4430]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  1.0 XMSubMetaSx_00 1+ Sexy Words
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Casey Schaufler <casey@schaufler-ca.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 533 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 12 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.25
	(0.2%), extract_message_metadata: 15 (2.7%), get_uri_detail_list: 2.5
	(0.5%), tests_pri_-2000: 9 (1.8%), tests_pri_-1000: 2.5 (0.5%),
	tests_pri_-950: 1.21 (0.2%), tests_pri_-900: 1.00 (0.2%),
	tests_pri_-90: 155 (29.1%), check_bayes: 153 (28.8%), b_tokenize: 9
	(1.7%), b_tok_get_all: 62 (11.6%), b_comp_prob: 2.9 (0.5%),
	b_tok_touch_all: 76 (14.3%), b_finish: 0.93 (0.2%), tests_pri_0: 320
	(59.9%), check_dkim_signature: 0.56 (0.1%), check_dkim_adsp: 2.9
	(0.5%), poll_dns_idle: 1.08 (0.2%), tests_pri_10: 3.0 (0.6%),
	tests_pri_500: 11 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org, vegard.nossum@oracle.com, tandersen@netflix.com, nir@lichtman.org, christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org, kees@kernel.org, torvalds@linux-foundation.org, casey@schaufler-ca.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false


Al Viro <viro@zeniv.linux.org.uk> writes:

> On Thu, Nov 28, 2024 at 06:43:31PM -0800, Linus Torvalds wrote:
>> A sane setup has lots of options
>> 
>>  - just use execve() with the actual name of the executable
>> 
>>  - use hardlinks and use execveat()
>> 
>>  - use open() on a symlink and then execveat() of that file, and get
>> the actual name of the executable behind the symlink
>> 
>>  - disagree about comm[] being relevant at all, and don't use it, and
>> don't use tools that do
>> 
>> and none of those are wrong decisions.
>
> Just one thing - IMO we want to use the relative pathname when it's
> not empty.  Even in execveat().  Because some wanker *will* decide
> that newer is better and make libc use execveat() to implement execve().
> Which won't be spotted for about a year, and when it does we'll get
> seriously stuck.

For clarity the only patches I have seen so far have been
about the fexecve subset of execveat.  AKA when execveat is has
not been supplied a path.

> I agree that for fexecve() the only sane approach is to go by whatever
> that opened file refers to; I'm not sold on the _usefulness_ of
> fexecve() to start with, but if we want that thing, that's the way
> to go.

The craziness is that apparently systemd wants to implement execve in
terms of fexecve, not execveat.

...

Wanting to see what is going on I cloned the most recent version of
systemd.  I see some calls that are generally redundant.  That is
systemd opens the executable and fstat's the executable to make
certain the executable is a regular file and not a directory symlink.

Which seems harmless but pointless unless something is interesting
is going to happen with the executable_fd before it is passed to
the kernel to execute.

The only case in systemd that does something interesting with the
executable_fd (that I could see) has to do with smack.  Please see
the code below.

Casey do you have any idea why systemd would want to read the label from
the executable and apply it to the current process?  Is the systemd
smack support sensible?

As it is written this seems like the kind of logic every process that
calls execve will want to repeat.

So I am wondering isn't it easier just to get the kernel to do the right
thing and not have deeply special smack code in systemd?  Does the
kernel already do the right thing and systemd is just confused?

Right now it looks like the sane path is to sort out the systemd's
smack support and then systemd should be able to continue using
execve like any sane program.

#if ENABLE_SMACK
static int setup_smack(
                const ExecParameters *params,
                const ExecContext *context,
                int executable_fd) {
        int r;

        assert(params);
        assert(executable_fd >= 0);

        if (context->smack_process_label) {
                r = mac_smack_apply_pid(0, context->smack_process_label);
                if (r < 0)
                        return r;
        } else if (params->fallback_smack_process_label) {
                _cleanup_free_ char *exec_label = NULL;

                r = mac_smack_read_fd(executable_fd, SMACK_ATTR_EXEC, &exec_label);
                if (r < 0 && !ERRNO_IS_XATTR_ABSENT(r))
                        return r;

                r = mac_smack_apply_pid(0, exec_label ?: params->fallback_smack_process_label);
                if (r < 0)
                        return r;
        }

        return 0;
}
#endif

Eric
