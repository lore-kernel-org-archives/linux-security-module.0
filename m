Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B299202C52
	for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343186; cv=none; b=tB05GpIQbKR5M2CPZN+lkBIIyGKAjzov0DXBEibLZYLOJbAz+XgSFjJl1sg4szlBsQ+OSDLio6iXekYD4bNwFjh/b5cNVmi1QNXGhwR0whQtt+bClMRj46Tn/ckCx8O/5zwOoWJ5COgWjAPkWqKEcs2fnZaKYmm31lArB9LNieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343186; c=relaxed/simple;
	bh=tsjkFMTjq/ky9DiXfGv71ckYUQvUiSS1Y4PYj3Fn5Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m19h8c5OHM2HpHvfCIDNhtjAVEwgAfGpwtbJg+4SmQ4RWWZuZZJvNNRUI/qJOBRtpVuaZXTBcaXT8YXsoAheGW/WwUfT2WWsfBNLdJvRLK0dRnUONKcfox+kWo6eXsw+rk9kyS+I9minOEiiHu53hck5QL6UI1YpUiZkmthSXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4BG9x097036083;
	Mon, 16 Dec 2024 18:59:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4BG9x09b036079
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 16 Dec 2024 18:59:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <86023b72-1a45-4115-b800-93297a3e2405@I-love.SAKURA.ne.jp>
Date: Mon, 16 Dec 2024 18:58:58 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: check size of writes
To: Leo Stone <leocstone@gmail.com>,
        syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
Cc: jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mortonm@chromium.org,
        paul@paul-moore.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <675f513a.050a0220.37aaf.0106.GAE@google.com>
 <20241216030213.246804-2-leocstone@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20241216030213.246804-2-leocstone@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp

On 2024/12/16 12:02, Leo Stone wrote:
> syzbot attempts to write a buffer with a large size to a sysfs entry
> with writes handled by safesetid_gid_file_write(), triggering a warning
> in kmalloc.
> 
> Check the size specified for write buffers before allocating.
> 
> Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4eb7a741b3216020043a
> Signed-off-by: Leo Stone <leocstone@gmail.com>

Since handle_policy_update() has two callers, you should check
inside handle_policy_update().

By the way, since syzbot found this pattern in multiple LSM modules,
do we want to ask Andrew Morton to send all patches in one pull request
(instead of sending trivial patch from multiple LSM modules) ?

> ---
>  security/safesetid/securityfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> index 25310468bcdd..5eba4c7f8d9e 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -254,7 +254,7 @@ static ssize_t safesetid_gid_file_write(struct file *file,
>  	if (!file_ns_capable(file, &init_user_ns, CAP_MAC_ADMIN))
>  		return -EPERM;
>  
> -	if (*ppos != 0)
> +	if (*ppos != 0 || len >= KMALLOC_MAX_SIZE)
>  		return -EINVAL;
>  
>  	return handle_policy_update(file, buf, len, GID);

