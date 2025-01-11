Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A73C23AD;
	Sat, 11 Jan 2025 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736563120; cv=none; b=OCbFGEWEYTGiyGevV5esuXL8Tf/t3VRKd6BdCRZUAAyTqaLn1wTjMuEu+3LrxtjypQa+ixM6oTogem1lsXK8nYlcp6LoswgaIgaWTn4yKzpkeuiTaW9EuDqCEJCqBFMAgHk2LqfrXuNUJF5lteImm4bsGE+c7LmXxq1T/Fb94yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736563120; c=relaxed/simple;
	bh=fLLO2+N6n8OC//6mcwSONP+dkmbCkPc3YDo7DDpWQz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dfg18Zt/Z662jUsZdLQpMTeSsUxwUuuF9seBBJxVSmg0Avqf/10vQRMjxcpchp8sqaI1/LN2Kqg6eI4bV4FVxr3yLKsxk7jhI0z8eaT77/qM2dNY+7YJkvyI5poF8KXyJPzIvwusaPFAVXUy6zjnoTVCblebaQ/+VT1uHYUVT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 50B2cAoM031442;
	Sat, 11 Jan 2025 11:38:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 50B2cAU1031429
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 11 Jan 2025 11:38:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <34d14dd5-4f0a-4594-b524-a85f287afc15@I-love.SAKURA.ne.jp>
Date: Sat, 11 Jan 2025 11:38:10 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [lsm?] WARNING in vfs_writev
To: syzbot <syzbot+910965bf9c26c6936f34@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com
References: <678119b0.050a0220.d0267.0029.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <678119b0.050a0220.d0267.0029.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

Already handled by commit dd2a5b5514ab ("mm/util: make memdup_user_nul() similar to memdup_user()").

#syz dup: WARNING in bitmap_parselist_user

