Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926B29430;
	Sat, 27 Jun 2026 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782539041; cv=none; b=Xv5xAWGHtOkghSJpTrtxm0ohKNu4wbtKTTFmYQQ5rvtcNZ7dC21vISQ8uhBwvFYY6BspAHG6Dpeq+qEnH72Qd5X0KUI+8IaG5gaHZEnjgRi+/xpvoxQbcBG08s0A3ZEQ0eq1JpjPM/Fj1AIBr5qLsEa9k6k9/EdH+CzFfVLNzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782539041; c=relaxed/simple;
	bh=P5wgvBuXmUaidxdlNmIMrXxGzaHpqUJSPr2jy2DF0qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=PfKfqa/xUsw+3DFXtVMrYYjy0g26RX5B4mUI3eCm7vCViB0G8O+IGGmdFYPYn/qnG+zCSythyfU5AZCYX6N/qgd+eUmxQYEBMxeNL70Xmz6WjvT1r6NmHNnIc7h4bVnCGCPGv5qQ7Sgku/4t5N3PbRfKBKDB26xNmN6FVPE629Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 65R5hUoq008228;
	Sat, 27 Jun 2026 14:43:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 65R5hTJX008223
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Jun 2026 14:43:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <790d4d56-4c24-4468-b588-722e6aa86ba1@I-love.SAKURA.ne.jp>
Date: Sat, 27 Jun 2026 14:43:29 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [tomoyo?] KMSAN: uninit-value in tomoyo_path_chown (3)
To: syzbot <syzbot+eaae8fa60ce81f1e4eeb@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <6a325dbd.dc986f81.2c135.0008.GAE@google.com>
Content-Language: en-US
Cc: jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com, takedakn@nttdata.co.jp,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <6a325dbd.dc986f81.2c135.0008.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/06/17 17:41, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2b414a95b8f7 Merge tag 's390-7.1-5' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12cff156580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0ca3b8cb3875012
> dashboard link: https://syzkaller.appspot.com/bug?extid=eaae8fa60ce81f1e4eeb
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 

The AI's analysis

  In this case, `chown_common()` skips setting `newattrs.ia_vfsuid` and `newattrs.ia_vfsgid`.

at https://syzkaller.appspot.com/ai_job?id=abea5dd9-2a6e-4669-a927-d87ef7833666 is wrong.
We always set newattrs.ia_vfsuid and newattrs.ia_vfsgid before checking for -1.

  retry_deleg:
  	newattrs.ia_vfsuid = INVALID_VFSUID;
  	newattrs.ia_vfsgid = INVALID_VFSGID;
  	newattrs.ia_valid =  ATTR_CTIME;
  	if ((user != (uid_t)-1) && !setattr_vfsuid(&newattrs, uid))
  		return -EINVAL;
  	if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
  		return -EINVAL;

Therefore, unless VFS people find something that can cause this problem,
this would be a random memory corruption which confused KMSAN.

#syz set subsystems: unclassified

#syz set no-reminders

