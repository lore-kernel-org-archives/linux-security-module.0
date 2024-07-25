Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E61CA8A
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jul 2024 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721889276; cv=none; b=RmdfSkQIv0CsMvbOAVHdKDSENN/yGr7i2Twz2MoF/btFemlNK+v0AddgUz4qJYlOGTdLG5AGBCvczwxfRlwholB7U91XhF0wSAEzh9yCsREclFhjmucoTVbggge/eWUgvWn8dzZEGy3CZ/Osq/Kwn+E4FoM0OV36VKbpwi7jcVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721889276; c=relaxed/simple;
	bh=IW5776Qd+17NPn98wMcoWCSRRXtSfhRzOdB/Q7Yztr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+oVmlDlw3cQ5ORgLuby9YnLAlf5VCDPJ/ud2sDD1LgcTA1VgQ7gwK8mYr1bAxbGl7vGg/Wee21QQ+25IMaz5FKvuvVIqb2gb1614KoobPyHRdS7CC0lwZvhxnOHEuuw6hdMj6Fw8JNUeRXk9+tST+0/tQO++S4PPEnnho5eCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46P6YO5V016429;
	Thu, 25 Jul 2024 15:34:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Thu, 25 Jul 2024 15:34:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46P6YNPt016425
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 25 Jul 2024 15:34:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d4b034c5-4b22-47c1-afbb-8ea1852a5e83@I-love.SAKURA.ne.jp>
Date: Thu, 25 Jul 2024 15:34:23 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security/tomoyo: Prevent message flooding if no Tomoyo
 loader is present
To: Yafang Shao <laoar.shao@gmail.com>
Cc: linux-security-module@vger.kernel.org, takedakn@nttdata.co.jp
References: <20240725054216.18587-1-laoar.shao@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240725054216.18587-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello.

On 2024/07/25 14:42, Yafang Shao wrote:
> After upgrading our OS to Rocky Linux 9, we've noticed an abundance of
> Tomoyo-related messages in the dmesg output, specifically indicating that
> Mandatory Access Control is not being activated due to the absence of
> /sbin/tomoyo-init. These messages repeatedly appear as systemd periodically
> checks for Tomoyo, but since the loader does not exist, it triggers the
> messages, as follows,

TOMOYO requires zero modification of userspace programs (including systemd).
That is, systemd is not checking for TOMOYO periodically. It is some other
program that is executing /usr/lib/systemd/systemd (maybe as a container's
init program), and TOMOYO is checking for /sbin/tomoyo-init when
/usr/lib/systemd/systemd is executed.

> While disabling Tomoyo is a straightforward solution to prevent the message
> flooding, it's suboptimal as we're unsure if any system components rely on
> its functionality.

No userspace programs rely on TOMOYO's functionality (except TOMOYO's management
tools including /sbin/tomoyo-init ). It is safe to disable TOMOYO.

>                    A more elegant approach would be to modify the logging
> mechanism to use pr_info_once() instead of the default one, which would
> reduce the number of redundant messages without compromising the
> functionality of the system. This change would ensure that the necessary
> information is logged once, preventing the dmesg from being cluttered
> with repetitive messages.

The message your patch tries to limit typically appears when /usr/lib/systemd/systemd
is executed from initramfs, for /sbin/tomoyo-init is installed inside the / filesystem
which will be mounted by initramfs, and /sbin/tomoyo-init becomes ready to execute
when initramfs transfers its execution to /usr/lib/systemd/systemd within
the / filesystem.

Therefore, this message is intended as a debug message that tells administrators that
you might have forgotten to install TOMOYO's management tools. I didn't expect that
administrators enable TOMOYO without installing TOMOYO's management tools.

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Thank you for a patch. But so far I don't think we need this change.

