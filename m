Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DCD202623
	for <linux-security-module@vger.kernel.org>; Fri, 18 Oct 2024 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264986; cv=none; b=aUta/2ZCccGqiyGcf/ZBu7khYOwg3QY3oCiQDGvdcpYdc+te7tBV9tWGxdWVMlr/c6pr/dwGWnOmjneLS44WkyJU4yLPRv2oy0b8kFLB+s68RKMcaQwCWSJ5BWXu6wSZcpGGvS71ztblHP7AhJJI4+kV+ukdqdFbfdO0+eAIq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264986; c=relaxed/simple;
	bh=S2b8raoKO2jpMm+bStWmIYHe9iT0SxSMwT/23htQqKU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GWDqF+itdDhJ72zJ9RiFqiHxTJIT4eJQ+ghNGr2f1xTbcqCSaCvHpgim5Ka2vS32VFYIMXIJCoKaFRBgESc9hne2EmvsAw/iPdu9Lcx9pfmgvPaS48zaJ2S0GyGPqMPfYVwXIHxh+lYofN8oSD3Dw9oUzVfj8e/zoijOWxl+akg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c24f3111so23223225ab.1
        for <linux-security-module@vger.kernel.org>; Fri, 18 Oct 2024 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729264983; x=1729869783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMasKnrStJmhL2WrAjeBgpPgH9uRvlMVH0mRvvyx83E=;
        b=PLr9pDVwOk3MY/mQiGTtgOWA2jVSVBum70P/x+DHoen8w3OVTLieY+YX4we19mw8gj
         kKvwrYAuwoVJ6dVmifHw5GG74DqWx32H9mAQLWEFYx48qkHxGnBh+usA/ZQq15SBvs+T
         iC+yqlZmVPWHjlTQP7hb9gfSRoZgmuAF8dTX28CfTXS8JgNKNcqNCGu2kDDTKKVPJ/Oq
         P8sZKrWiC+6pF2oTLbYCPhoREgPMGNl4yO/BKnt7jR9sNAsBC6BWTxkpJo0InMzTUjfw
         JUjeCxdnq3azHqNZUUSLAAisvQD5zLmlhEbLCrZCMBBONSps+NJa56YUV/Pl9FaANGK9
         LVEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4BwfZK/NpsDmkqMIIEVrCsv9rMlUJDTJ615umLq8duplU0UQfuGsA/hw+9K/Kv2rNN+tZXXqSQwuDhx6ne+ZR5ewP2aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/x+aklbPRhRNQ6lS3Xq+7BmlIYTBlH+hvoxzptkU47c3fIWB
	LNGZSW6W2SBKY1Tr6UTv3JeCqeyecwomxN7QhwUZ8T93dS5jPpDID4zav3z0aIpsdiUSVCvo0/Z
	ZRTpYNphp0ju3fknk+LsXECFYSpidgZX+YUUTj6ofGxolPcjIcb5959s=
X-Google-Smtp-Source: AGHT+IFaa43STGFMHe0/hOCzeExl2B3M5A5tpOKNGOU/pV3YF8Pp+q0cS6YasT/jYWn8gro3UAO0r1Ann3dOBmvYjNAqMsS6YWOP
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144a:b0:3a3:3e17:993f with SMTP id
 e9e14a558f8ab-3a3f405d064mr29660255ab.8.1729264982842; Fri, 18 Oct 2024
 08:23:02 -0700 (PDT)
Date: Fri, 18 Oct 2024 08:23:02 -0700
In-Reply-To: <46d8cfe7db6f381c99455159bff1c2220dff4aed.camel@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67127d56.050a0220.10f4f4.0016.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
From: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	ebpqwerty472123@gmail.com, eric.snowberg@oracle.com, hughd@google.com, 
	jmorris@namei.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com

Tested on:

commit:         31063ab7 mm: Split locks in remap_file_pages()
git tree:       https://github.com/robertosassu/linux.git remap-file-pages-locking-v1
console output: https://syzkaller.appspot.com/x/log.txt?x=15502240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b6f5c91e13aedf5
dashboard link: https://syzkaller.appspot.com/bug?extid=1cd571a672400ef3a930
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
