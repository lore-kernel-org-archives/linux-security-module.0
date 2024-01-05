Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA82421C
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jan 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0cWyRjH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3e6c86868so10348135ad.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jan 2024 02:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704451922; x=1705056722; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBT+5/7p/hP7YJ42E/6BHMyTtHE5R/h4jhHrdAWccVk=;
        b=c0cWyRjHm/fRh6Azc4qXXswE0JLfadRcgm3wywLwNtylNU2hExqD8nehRqcqu5MXyh
         JwJdKhzc1wgqLcEV9yG+PJQOHQdI4jPn8Lpp4zgV3KKUh2sR4x09az5qB2WcovsMpTlF
         6ngBMJfXmqR6ZIkMKpeGNuWYWwWCB3YdAeXHlNg79N0ZTceLHNAKTZRsXpqZFt2P591I
         wokehRFRxFPVmWBAJ4D8N4amd8CvP1MtTj9N2hUHRlEGlS78Wz0cjS87A4XuJVZXvloP
         axyaheAPPP2hYtVd3NLOxpePIiwzeyUiAYZXKusPmg1HsMVlv8VnFPMnXqfye3fh40Z5
         2EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704451922; x=1705056722;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBT+5/7p/hP7YJ42E/6BHMyTtHE5R/h4jhHrdAWccVk=;
        b=kQm6/H8F/goTDOj1Xaxnp5gwCY0iCNtrBrOcC8fnOMO4bRgPm8NbuWRIceX4S1bD4U
         HfkL6BKVah8jOo3veFpOEM/2jrBF5sdIaRdIMZICdbTxndeCUxKe8gkZVzV3teveVwcK
         NhYwnt89uInKRr4RVT2r7UkTtCWeuvz9Ge0V7lOeWqKjqRMsY0xM96xk/VudaWwHFl6F
         se2qnnjQgW6fWRuJ5DTPLd1HTvXCNBfTTRALBRLqQigjwf+hGK+HxmaahbDEMB1q+MqE
         ioLl/UOPlq1S/+V91fPjicXp/TYlkMHMnM//F591DgnXoox9WdviqG+5fnqfNiYb8qJF
         8a3A==
X-Gm-Message-State: AOJu0YyC383/I5jjuatvZd9cjWuDVuW4gRag+tWimTS5bNLJaqpEyZ1N
	/f34lqiy+R91FrbeP7mJydK6rPFpKhfLWg==
X-Google-Smtp-Source: AGHT+IEf4XMdfJRkGptUIyum00hnlAI3bfxeJ5G2gFbi6ePEJ8wcW1uQZWQVxXGxs6swFcKJfJ5JTg==
X-Received: by 2002:a17:902:d642:b0:1d4:c98d:4032 with SMTP id y2-20020a170902d64200b001d4c98d4032mr1677644plh.23.1704451921799;
        Fri, 05 Jan 2024 02:52:01 -0800 (PST)
Received: from ?IPV6:2409:894d:e2c:2021:a4bf:7613:333a:27d4? ([2409:894d:e2c:2021:a4bf:7613:333a:27d4])
        by smtp.gmail.com with ESMTPSA id c13-20020a170903234d00b001cf65844874sm1122495plh.45.2024.01.05.02.52.00
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 02:52:01 -0800 (PST)
Message-ID: <2d496880-0c3c-4198-85ae-2819b3288336@gmail.com>
Date: Fri, 5 Jan 2024 18:51:56 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-security-module@vger.kernel.org
From: "cauc.peter" <cauc.peter@gmail.com>
Subject: help for concepts about key management of the Linux kernel security
Autocrypt: addr=cauc.peter@gmail.com; keydata=
 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
 gDtM6HfU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I recently studied articles related to key management of the Linux 
kernel security module and found some strange concepts that bothered me, 
such as the meaning of key Possession.
After reading the kernel keys.txt document and man 7 keyrings still no 
solution.
For example, using the keyctl command in user mode to create a session 
shell is different from directly creating a new shell, keyctl show @s 
has different output
and How to add other shells to the same key session?




I recently studied articles related to key management of the Linux 
kernel security module and found some strange concepts that bothered me, 
such as the meaning of key Possession.
After reading the kernel keys.txt document and man 7 keyrings still no 
solution.
For example, using the keyctl command in user mode to create a session 
shell is different from directly creating a new shell, keyctl show @s 
has different output
and How to add other shells to the same key session?



Looking forward to your answer, thank you very much
