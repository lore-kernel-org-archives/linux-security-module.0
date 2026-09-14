Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975747F2F3
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395129; cv=none; b=qkI9gh3pCuckIrjEeAd+YSoN2RN2mV2vgKCgZWjojCsln+/LozD2dKvLZJwx4ljt1TVj9j9ZDVYkLSLrT8Z80Al9FBqMBgZRWhIduueXwpHsuKAIZtlwcvsgn7rp4bCDlwZFuMTYuaIZbatcJ32sF9j1M1ZSgqvLGzKyOZVxGNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395129; c=relaxed/simple;
	bh=FYgE/qMDYyeMl2lVwY7dAtgyDXOfNxxwb4+vbhAhdRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5m1UDFpJ1KT2FAH2B5ROFUd/ubiQxCqhT6K+1hNabqIzO24keM6x941lNIaxyaI7hy7sj0ldqRsECnyUPcD7RPe55uzLCNRwddaOEMJCM+L82jISiE2G5+uxO9gpGCaL6eVLmlbtVQ1niwxDlt33VWpVjfFq/1y7+gnYblyJY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4MnOGfA; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4MnOGfA"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b965f447cso15774585e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789395119; x=1789999919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ucveROnBiD9Bvg19k0xNDw/2fESh5irWztcJl/INm4w=;
        b=C4MnOGfA6THW2WjLmuyh2Z/iXY739+lEku8tmirxGv3aBFMQYNwL7hao5ZkcHr18p8
         Y1ep3K8Z1r26osoboxiApt2P93B8yYJTl9PsXTTe9XJIlTHhVXYpQDtJYXFa5T1R70uG
         P+w06A5E3mx1tUEB99v8++Vfrp1xmZbZEQEiKuksJF2u+bXdT/87I+bhiCDh/zc6sAXV
         J6zZWwX/9KpH3bM+LFIHs8rAbAVkDE2F+rAMDK5se3kPJ2wLyc/VMoI8AaasHVLvJHK9
         pfu7f9PearY403xsBDJnQzsjht5ETXVm9/LNnRZHlyo9jI8kkKCNLRu4MgMlwOhgiKnf
         KwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395119; x=1789999919;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucveROnBiD9Bvg19k0xNDw/2fESh5irWztcJl/INm4w=;
        b=p7kZKRiPyYCpIZ+fgTxXyYwrs9emBy7QqO40nkdodajzN7zO9nsVT5V/32/O1O1Pp9
         VkQHatk5hb8Foy2nB9TmfElLM3Hy3cLIwSJ6cJxKp63pxtASEIGOxJR7hE+54XVaT1rX
         HtJ8/xh2+v0vjwEivd94/HLYmgdPTefABaFxU4mQj8hW+f7coPIvCPUFhtuHHCaHnT7s
         V+XD1FV9zEm+4Qm9O6BXvTOkxpWwaRoTbzUkkC/GMYDyw5pXiKK0RoVIRnJPadcigdnI
         OWDJWBlHD3ms8gquAvMA4P1OARA92AHbHMTbnFr1/jq95TnVG3q4z68ZF966OUTXJySa
         CCGQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/pOVYDuZ7kRMaV0/0VnMi7krI0ozuSbUzuZAo7HBGDKj8N/lqPLOFrhiGJvNAuzxWKAd43sCNNDHLXKIBxdw2qWRD0OE=@vger.kernel.org
X-Gm-Message-State: AFuF++mVariwYUgYabdSNjBkweZbvpIJ2nrPdHhVOz3HChTxbz/y22s0
	wtlosi3Kk56K+Sjrc79LApAORot2jpVI2Zhabo/3LvXXakUOjKUkmgaq
X-Gm-Gg: AYBFou3zbM1NN0XgtRRl8yKTzqXkxJV9X7hBbsfDP/BNROwaD+/vNHlft8Wbdjg9+PO
	CzDE/OHZ1aR1J/ZiZESNBa48DVJGGDEH5b03aGwd/2kYcZSiR9cB0bkdLOOWe8dJInBx+tcLbpJ
	1l1jmctHFXSLjRB1R9TdfZTKEHTDnRBfvTJFyItAia1JytEIlatzcZdRP21pWvCMZGbUPtwNAmJ
	xqczd/MAt1dfJWKPNG+3QYxGJ0WekNBK6NhUXg+EQL/FiygDgepj3K2pdzKGI29PipbWuEt0ZhB
	IUQSTlEAFCZz3Src1Sl/duTkNTVgNRTw2+2bioX+AgG81stuzT9elThMNj1+V5B4vEiYcFFzqJ3
	NrK84MWAB1Z9lTsMOxTVL8HrJI98J/V1X3EmJFz0mSdws7XjJ1DN87gRP26MmNaEB0TfJ9QAoNS
	QNlpeJsdBIrzJWA66W1qUAz8CpOi91cFEFJFevJZHBtIEoeF4LWYtXyCuKlM31p4L4Pk895mE0I
	FXTbyUnuj4=
X-Received: by 2002:a05:600c:3b9a:b0:49c:ffde:45ff with SMTP id 5b1f17b1804b1-49e7a66b656mr33565995e9.17.1789395118802;
        Mon, 14 Sep 2026 07:11:58 -0700 (PDT)
Received: from penguin-ubuntu.lan ([2a00:23c6:6405:9301:838b:b854:bb11:52b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e63c9a7c9sm535965175e9.13.2026.09.14.07.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:11:58 -0700 (PDT)
From: Oxana Kharitonova <webprosto@gmail.com>
To: gnoack3000@gmail.com
Cc: gnoack@google.com,
	jmorris@namei.or,
	landlock@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	oxana@cloudflare.com,
	paul@paul-moore.com,
	serge@hallyn.com,
	wangyan01@kylinos.cn,
	webprosto@gmail.com
Subject: Re: [PATCH 0/6] landlock: Add POSIX message queue scoping
Date: Mon, 14 Sep 2026 15:10:23 +0100
Message-ID: <20260914141156.258282-1-webprosto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821.d42cd4b82f91@gnoack.org>
References: <20260821.d42cd4b82f91@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Günther!

Apologies for the delayed reply. I took some break. 

Thank you very much for the detailed explanation and for the 
test program.

On 21/08/2026 09:46, GÃ¼nther Noack wrote:
> Thank you for sending this!
> 
> I have a high level question about this patch set:
> 
> You are adding a check to hook_file_open(), but the existing
> hook_file_open() can already prevent mq_open().
> 
> The following experiment illustrates this:
> * Restrict LANDLOCK_ACCESS_FS_READ_FILE and LANDLOCK_ACCESS_FS_WRITE_FILE
> * Try to run mq_open("/foobar", O_CREAT...)
> 
> Depending on the installed PATH_BENEATH rules, you now see differing behaviour:
> 
> * If we allow READ_FILE and WRITE_FILE on nothing, mq_open() is *DENIED*.
> * If we allow READ_FILE and WRITE_FILE on /, mq_open() is *DENIED*.
> * If we allow READ_FILE and WRITE_FILE on a mounted /dev/mqueue, mq_open() is *ALLOWED*.
> 
> So it seems that the existing file system restrictions are already
> preventing POSIX message queues from being opened?  And not only that
> -- since such Landlock policies are already quite common, it seems
> likely that many existing landlocked programs are already restricting
> opening of POSIX message queues today.

The additional check in hook_file_open() adds a restriction for two sibling domains
created under the same parent. If both siblings share filesystem
access, but must not communicate with each other through POSIX message
queues, the scope check prevents one sibling from opening a queue created
by the other. 

Although I can't say how practical this use case is. I see that it adds 
additional overhead for non-mqeuee files too, but it doesn't seem significant 
as it only checks the inode type and mqueuefs superblock magic.

If you think it's not worth it, I'm happy to remove it.

> So, to clarify:
> 
> * What your patch set is adding is only that we are now additionally
>    taking the Landlock domain scope into account?
> * This distinction only makes a difference for landlocked programs
>    that do not restrict READ_FILE/WRITE_FILE or that do restrict it and
>    then allow-list READ_FILE/WRITE_FILE on a previously mounted
>    /dev/mqueue.
> 
> Maybe this would be interesting to clarify a bit more prominently in
> the cover letter, because it reduces the applicability of this
> patchset?

Agree, I'll add more details in the cover letter. 

> Attached below is a LLM-generated (but double checked) test program
> which you can use to try out the creation of mqueues.  (As first
> argument, use "-", "/" or "/dev/mqueue".)
> 
> What *might* still be interesting to restrict though: While mq_open()
> checks the READ_FILE and WRITE_FILE rights, it checks none of the
> LANDLOCK_ACCESS_FS_MAKE_* rights -- the message queue gets still
> created, even when the mq_open() is denied and returns with an error.
> 
> To expand on Justin's comment in [1] -- it feels that there are maybe
> still some gaps in the "lifecycle management" of these message queues
> that might be worth thinking systematically about, because both
> mq_unlink() and the creation of the message queue entries are
> currently apparently not restrictable yet?  It makes me wonder whether
> hijacking of message queue names (creating same-named queues in other
> Landlock domains) is a problem then?  Do you have thoughts on this?

I need to think about it more and check how the mq_unlink works, taking 
into account the comment from Justin and Mickaël. 
I'll follow up with a more complete answer.

> 
> Thanks,
> –Günther
> 
> [1] https://lore.kernel.org/all/amKDYoOSvHMzVbKX@suesslenovo/


