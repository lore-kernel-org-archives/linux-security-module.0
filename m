Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C960C001B0
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Aug 2023 14:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjHGOZP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjHGOZO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Aug 2023 10:25:14 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389DAC2;
        Mon,  7 Aug 2023 07:25:13 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 377EP63N094543;
        Mon, 7 Aug 2023 23:25:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Mon, 07 Aug 2023 23:25:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 377EOsHZ094511
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 7 Aug 2023 23:25:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ab7b4099-d238-e791-6dc2-25be5952798c@I-love.SAKURA.ne.jp>
Date:   Mon, 7 Aug 2023 23:24:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] TaskTracker : Simplified thread information tracker.
Content-Language: en-US
To:     Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        audit@vger.kernel.org, linux-audit@redhat.com
References: <41d03271-ff8a-9888-11de-a7f53da47328@I-love.SAKURA.ne.jp>
 <2029076.tdWV9SEqCh@x2>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2029076.tdWV9SEqCh@x2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/07 7:01, Steve Grubb wrote:
> This is where the problem begins. We like to have normalized audit records. 
> Meaning that a type of event defines the fields it contains. In this case 
> subject would be a process label. and there is already a precedent for what 
> fields belong in a syscall record.

What is the definition of "a process label"? SELinux / Smack / AppArmor are using
security_secid_to_secctx() hook for providing string data for the subj= field.
I don't think that they are restricting characters that can be included.
Then, what is wrong with returning subset of ASCII printable characters from
tt_secid_to_secctx() ?



static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
{
	return security_sid_to_context(secid,
				       secdata, seclen);
}

static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
{
	struct smack_known *skp = smack_from_secid(secid);

	if (secdata)
		*secdata = skp->smk_known;
	*seclen = strlen(skp->smk_known);
	return 0;
}

int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
{
	/* TODO: cache secctx and ref count so we don't have to recreate */
	struct aa_label *label = aa_secid_to_label(secid);
	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED | FLAG_ABS_ROOT;
	int len;

	AA_BUG(!seclen);

	if (!label)
		return -EINVAL;

	if (apparmor_display_secid_mode)
		flags |= FLAG_SHOW_MODE;

	if (secdata)
		len = aa_label_asxprint(secdata, root_ns, label,
					flags, GFP_ATOMIC);
	else
		len = aa_label_snxprint(NULL, 0, root_ns, label, flags);

	if (len < 0)
		return -ENOMEM;

	*seclen = len;

	return 0;
}

> 
> What I would suggest is to make a separate record: AUDIT_PROC_TREE that 
> describes process tree from the one killed up to the last known parent. This 
> way you can define your own format and SYSCALL can stay as everyone expects it 
> to look. In the EXECVE audit record, there is a precedent of using agv[0]=xx 
> argv[1]=xx argv[2]=yy  and so on. If you want to make these generally 
> parsable without special knowledge of the record format, I'd suggest 
> something like it.

Yes, https://lkml.kernel.org/r/201501202220.DJJ34834.OLJOHFMQOFtSVF@I-love.SAKURA.ne.jp
used AUDIT_PROCHISTORY instead of LSM hooks, but that thread died there.

