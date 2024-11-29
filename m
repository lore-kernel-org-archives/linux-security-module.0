Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C014D430;
	Fri, 29 Nov 2024 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908821; cv=none; b=oTWapRYDIvXnPNvW/1xNlwfSpiF6jreQFVShh/s7K8KClXZ2g2pEuqzGm+8jSuALF4L6cn2Qvh011ADSnhNIN1GnFz9R18bfQ4cQEJiHeWfG2MHFqXYgUFQgijQO6rx1KBEgkNseTYZPWLFBAOEzkzyNxopLW6ApfkZ34Fa2cIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908821; c=relaxed/simple;
	bh=e/oiH+5eV0PnzU69I+789jp/4kAzHHx31CuIFIOmRe4=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=qMNaO8+Lak+0d7RSl+gqzNMq5nFizPtsv/dvdhJVwR7qhL97kXaqXWgpKJ76rQYRtmY346PvGy2T3mh4AtCwmNT8xB9HgK7lMeU6x+mX+bd4wRypodV+Sy/ELHdDwzNt2ea/eYAOvGJV9uAXI96OjZZnzDyKtwF3pZ6gEQQFV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:46322)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tH6kD-006Z6q-8p; Fri, 29 Nov 2024 12:33:37 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:44368 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tH6kC-00AdPl-AQ; Fri, 29 Nov 2024 12:33:36 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Kees Cook
 <kees@kernel.org>,  linux-kernel@vger.kernel.org,  Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>,  Nir Lichtman <nir@lichtman.org>,  Tycho
 Andersen <tandersen@netflix.com>,  Vegard Nossum
 <vegard.nossum@oracle.com>,  linux-security-module@vger.kernel.org,  Al
 Viro <viro@zeniv.linux.org.uk>
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
	<87h67qoeh5.fsf@email.froward.int.ebiederm.org>
Date: Fri, 29 Nov 2024 13:33:19 -0600
In-Reply-To: <87h67qoeh5.fsf@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Thu, 28 Nov 2024 22:23:18 -0600")
Message-ID: <87mshhn8cg.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tH6kC-00AdPl-AQ;;;mid=<87mshhn8cg.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18jUckRObL07lbPAu08BtIHDhNQReedVyU=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4422]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XMSubMetaSx_00 1+ Sexy Words
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Casey Schaufler <casey@schaufler-ca.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 397 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 13 (3.3%), b_tie_ro: 11 (2.8%), parse: 1.99
	(0.5%), extract_message_metadata: 6 (1.5%), get_uri_detail_list: 1.79
	(0.5%), tests_pri_-2000: 6 (1.5%), tests_pri_-1000: 4.2 (1.1%),
	tests_pri_-950: 1.92 (0.5%), tests_pri_-900: 1.52 (0.4%),
	tests_pri_-90: 66 (16.6%), check_bayes: 64 (16.2%), b_tokenize: 9
	(2.3%), b_tok_get_all: 7 (1.6%), b_comp_prob: 2.6 (0.6%),
	b_tok_touch_all: 42 (10.7%), b_finish: 1.01 (0.3%), tests_pri_0: 256
	(64.4%), check_dkim_signature: 0.90 (0.2%), check_dkim_adsp: 3.7
	(0.9%), poll_dns_idle: 1.11 (0.3%), tests_pri_10: 4.1 (1.0%),
	tests_pri_500: 22 (5.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org, vegard.nossum@oracle.com, tandersen@netflix.com, nir@lichtman.org, christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org, kees@kernel.org, torvalds@linux-foundation.org, casey@schaufler-ca.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false


Casey and the smack folks my apologies for copying you in.

I just read the code below a little more carefully and it is definitely
a systemd bug.

mac_smack_read_fd reads the xattr that smack will apply as a label if it
is present.  So there is no reason for systemd to apply the label
itself.  Worse smack_bprm_creds_for_exec applies checks before
applying the label (aka is the superblock trusted) that systemd doesn't.

Which means systemd might apply a label from a smack xattr when
smack wouldn't.

> static int setup_smack(
>                 const ExecParameters *params,
>                 const ExecContext *context,
>                 int executable_fd) {
>         int r;
>
>         assert(params);
>         assert(executable_fd >= 0);
>
>         if (context->smack_process_label) {
>                 r = mac_smack_apply_pid(0, context->smack_process_label);
>                 if (r < 0)
>                         return r;
>         } else if (params->fallback_smack_process_label) {
>                 _cleanup_free_ char *exec_label = NULL;
>
>                 r = mac_smack_read_fd(executable_fd, SMACK_ATTR_EXEC, &exec_label);
>                 if (r < 0 && !ERRNO_IS_XATTR_ABSENT(r))
>                         return r;
>
>                 r = mac_smack_apply_pid(0, exec_label ?: params->fallback_smack_process_label);
>                 if (r < 0)
>                         return r;
>         }
>
>         return 0;
> }


Which means the systemd code should really be:

> static int setup_smack(
>                 const ExecParameters *params,
>                 const ExecContext *context) {
>         int r;
>
>         assert(params);
>         if (context->smack_process_label) {
>                 r = mac_smack_apply_pid(0, context->smack_process_label);
>                 if (r < 0)
>                         return r;
>         } else if (params->fallback_smack_process_label) {
>                 r = mac_smack_apply_pid(0, params->fallback_smack_process_label);
>                 if (r < 0)
>                         return r;
>         }
>
>         return 0;
> }


At which point systemd has no need to open the executable file
descriptor and thus no need to play with fexecve.

Eric
