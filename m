Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F64E236B
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610607; cv=none; b=A03Pea6vCQGxyujw+Gp1JFEv/1XcesUc6xpnHLtwRmCS+ZxLhyCYZsYOHN2OAV0ILGwtVckh5TnBOFjckYDACrKKbXknw81KxaM4LwD6qp3hBCmrElSJmScI3v/Mkb/kzodmL2g39NYl2CQN8CHd5zAijLoL4mEURqdcsSYKdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610607; c=relaxed/simple;
	bh=eK/eJ3hguVN3HC5ZratOGBwPh0MmUBHZAM2stBK3p20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPk1x60RI7LvkSHPCo9xF6mcNhC4+YT6WsEpbmU0yTk5vix61Zwaui14tAocFKI/UkH/RSxtLtVPC6B1itpfUXMZ/vXNL63A7DRKrEP+DYGrEYTvx4dlLXpD92aOmKjKgeY7oSQJucBQOz3t3VChVGaltMYuD+o/RjRjE0CprBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuTsTw5F; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuTsTw5F"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffa15f67fso11714045e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610604; x=1791215404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TUupXe47hKEwtrJAakpSRuAqpv3FGIO9UcE3gl7qRpw=;
        b=GuTsTw5FHOlnCxMbllfdMQRs2AnHKkLQmOx3jmsPoKeYSnOd9RiAwvSIWFBP4te9UK
         Q7/pP2NIfSvfuSDzyUmq8B8gQki3oe9fyZHfjRDWSRT/Jfx+NBeOzWnNBdRZBIMZAuG7
         MIOUAS4qOk/tfUEPEiqonEIJaM0AfxnwDnjIRZ7FqzhxC53P48nPPvjFQQRTN4S4PvC4
         0h2ygoHyJfuYlojDMwWk9qEeBWO7B19sQkeYPQuqpI/Nw14yeFO9wX2IAehQPPhaCQtY
         8gnek4jdQqwOWWW5VwcdsAC/D1XTplq+UpONaHcpHUOa8pwVmJB5/h2btVeXpEbvroQ5
         ZwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610604; x=1791215404;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TUupXe47hKEwtrJAakpSRuAqpv3FGIO9UcE3gl7qRpw=;
        b=IUSQVTgyaCRIufpsMZfx1NofX2Folhfi/REIPNFrnVJXBTBsV61EdZbBXFaMOa2OLo
         urtt2qADiyZn0liO4vJ0f/LLH+5ppLxb8pobb2JMKz+3RwliDWRHddoAeVU/dDgjq3ZN
         WhkyR0H6AO2KaEuixD9Twa38W1r9xN899h4hDa765E0+yp55qNOgJJXd6PKGs5WUNHqw
         vK2LRZijQjoYkBXyN3KEAV5g9emCanao2Uh04MOOEj3mYg3PpPSidUJb7QGyemEUjDdB
         wRM2bXGo34LdUFxJlNSXcbOxAdcp0DuwFXSizdSStkYC5GjIbRMeD99kLluL3bI9rBBv
         xVOw==
X-Forwarded-Encrypted: i=1; AKwUvBz+7DNA0igufsmz47LEB46jE6+6mYKMF0Oav5MeL80KO1jvxtMwsqZCD2irckpVW1cjUGiOZ/jLMquJl0c0nyE1Ds2YYcs=@vger.kernel.org
X-Gm-Message-State: AFuF++n0eVGumcIB5aoHNLWB+0/vicyNH+/Fv1muJR+rEtGBzEDjkylr
	5yWKFpnFIessqJsJL+Ok9Z9j7IW17dRiJuMDMtfnz8wbTHVn+URxr5G4
X-Gm-Gg: AYBFou3WDiRMG2494d49bwaTC1k7qSaFc+CUgt8Dth12Pyb4CE6SrqCFevExo3SXKIE
	/F8FXgoXicpAKeKK0yB1udFRo7LZIAtaCfakZ5xvStI5BG6NtCAyDS9WrJu4pT9jmmKJT3bO2ck
	F36fRcwpH4pg6TM2e9l9TMqSYmZui6POorDNDu57lYM1PLPB/o3kv9uFhgbIR6R4mkaBZbw4eOo
	jwgQtT8jvKhG9dKI6bI0Y52yknfLkPGrcQNkcn1Zg2j416zLb9ZJDWkchoBUyJNRPIPmzzDdaoS
	rSh6QGX3f3rgDSBt8KwJ2prozAxa8HkcDT/cApAI/9cJ4LWtn6Yne32Wxb4n74kNXt5FUToXFAp
	INun/w5wIck+8/A9wtcWh09RwfZlvrGZAqLiuMJgToHV+kt0Jc+6fgrsEHJXscszi4XJ5lcDc0f
	Qd5cSVjGqFnMEXqVQmKZG2Ov6QqeTBp8vgv9X5wNS6PZzkCe/7+p2+2jPTYGSl4cZXlTLz+5V8s
	ZHsLNWeX4vIU69MjXRa
X-Received: by 2002:a05:600d:6402:10b0:4a0:c01:1902 with SMTP id 5b1f17b1804b1-4a00c011a5fmr9990865e9.2.1790610603593;
        Mon, 28 Sep 2026 08:50:03 -0700 (PDT)
Received: from penguin-ubuntu.lan ([2a00:23c6:6405:9301:5b51:b317:1deb:4845])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a354c47sm29772532f8f.15.2026.09.28.08.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:50:02 -0700 (PDT)
From: Oxana Kharitonova <webprosto@gmail.com>
To: webprosto@gmail.com
Cc: gnoack3000@gmail.com,
	gnoack@google.com,
	jmorris@namei.or,
	landlock@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	oxana@cloudflare.com,
	paul@paul-moore.com,
	serge@hallyn.com,
	wangyan01@kylinos.cn,
	utilityemal77@gmail.com
Subject: Re: [PATCH 0/6] landlock: Add POSIX message queue scoping
Date: Mon, 28 Sep 2026 16:47:34 +0100
Message-ID: <20260928155002.742984-1-webprosto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914141156.258282-1-webprosto@gmail.com>
References: <20260914141156.258282-1-webprosto@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Günther!

As promissed, I'm following up with a more complete answer.  

On 14/09/2026 15:10, Oxana Kharitonova wrote:
> On 21/08/2026 09:46, GÃ¼nther Noack wrote:
>> What *might* still be interesting to restrict though: While mq_open()
>> checks the READ_FILE and WRITE_FILE rights, it checks none of the
>> LANDLOCK_ACCESS_FS_MAKE_* rights -- the message queue gets still
>> created, even when the mq_open() is denied and returns with an error.

I revisited my changes and noticed the gap you mentioned regarding
mqueue creation. Thanks for highlighting it. I'll address it in v2.

>> To expand on Justin's comment in [1] -- it feels that there are maybe
>> still some gaps in the "lifecycle management" of these message queues
>> that might be worth thinking systematically about, because both
>> mq_unlink() and the creation of the message queue entries are
>> currently apparently not restrictable yet?  It makes me wonder whether
>> hijacking of message queue names (creating same-named queues in other
>> Landlock domains) is a problem then?  Do you have thoughts on this?
> 
> I need to think about it more and check how the mq_unlink works, taking
> into account the comment from Justin and Mickaël.
> I'll follow up with a more complete answer.

Regarding the lifecycle management of POSIX message queues, I haven’t
found a good solution yet. I experimented with test programs, but the
main constraints come from the POSIX message-queue semantics. A queue is
independent of its creator’s lifetime and remains until mq_unlink() is
called explicitly and all open descriptors are closed. Its name must be
unique within the IPC namespace, but the same name can be reused after
the existing queue has been unlinked.

If mq_unlink() is restricted for a process, a stale queue could remain
and that process might be unable to clean it up. This seems to be the
concern Mickaël raised in [2]. However, Landlock restrictions apply to
the restricted process or domain, rather than globally to the queue, so
another process might still be able to access or unlink it if its
permissions allow. Therefore, I don’t currently see how to restrict this
correctly through a Landlock policy, other than documenting the
limitation. Let me know if you have other thoughts or I'm missing
something.

>>
>> Thanks,
>> –Günther
>>
>> [1] https://lore.kernel.org/all/amKDYoOSvHMzVbKX@suesslenovo/

Thanks,
Oxana

[2] https://lore.kernel.org/all/20260728.Heephie1tai3@digikod.net/
