Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E188C433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Oct 2021 08:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7B56008E
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Oct 2021 08:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhJYI3r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:29:47 -0400
Received: from mail.astralinux.ru ([217.74.38.119]:40832 "EHLO
        mail.astralinux.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhJYI3l (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Oct 2021 04:29:41 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2021 04:29:40 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 7D7242DC6BE7;
        Mon, 25 Oct 2021 11:17:48 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id f1O_iW9pzHUU; Mon, 25 Oct 2021 11:17:48 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 071A62DC6C00;
        Mon, 25 Oct 2021 11:17:48 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bjlEArLrbEAd; Mon, 25 Oct 2021 11:17:47 +0300 (MSK)
Received: from [192.168.32.67] (unknown [192.168.32.67])
        by mail.astralinux.ru (Postfix) with ESMTPSA id BE73A2DC6BDA;
        Mon, 25 Oct 2021 11:17:47 +0300 (MSK)
Subject: Re: lsm-stacking: fix broken lsm audit
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Cc:     akovalenko@astralinux.ru
References: <20210806070245.26338-1-dmastykin@astralinux.ru>
 <f2eacf08-d1a1-e8a1-eae0-28e4e54b50ff@schaufler-ca.com>
From:   Dmitry Mastykin <dmastykin@astralinux.ru>
Message-ID: <539ad779-3dc7-91d4-4f7d-398821207356@astralinux.ru>
Date:   Mon, 25 Oct 2021 11:17:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f2eacf08-d1a1-e8a1-eae0-28e4e54b50ff@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Casey,

 > On 8/6/21 11:01 PM, Casey Schaufler wrote:
>> On 8/6/2021 12:02 AM, Dmitry Mastykin wrote:
>> Hello,
>> These patches address the problem of not processing LSM audit rules.
>> Problem was introduced in lsm stacking series.
> 
> Thank you. I will incorporate these changes in v29.
> 
thank you for the v29.
I think the following fix is still required:

---
  security/security.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index e33c8ccc06a0..fd14064e9106 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2934,7 +2934,7 @@ int security_audit_rule_match(struct lsmblob 
*blob, u32 field, u32 op,
  			continue;
  		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
  					       field, op,
-					       &lsmrule[hp->lsmid->slot]);
+					       lsmrule[hp->lsmid->slot]);
  		if (rc)
  			return rc;
  	}


Kind regards,
Dmitry Mastykin

