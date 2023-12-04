Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HWdaDdQP"
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143F4C1
	for <linux-security-module@vger.kernel.org>; Mon,  4 Dec 2023 11:33:16 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35d7e22ccfeso316695ab.0
        for <linux-security-module@vger.kernel.org>; Mon, 04 Dec 2023 11:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701718395; x=1702323195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPLyZ99seCPicBCXDZB9lqIEFSMnRlWV8gcxMk/enRM=;
        b=HWdaDdQP3ltISdSCmnLELXLyDYbmEIkSPNq7+iRhMRohQne+toMA26NV7TIZAaWfCz
         Gl9qadg2vNgjXVLYMhucmflzexcjjRwCNweq3jtJN2muO5voL92QWhSj4A17+nV/zNtw
         El4LYiFkpLhWypQnGyIxKZd3VooMXdnSACkXa84LkmYbADNJ9RU0rqN36+lM6LP49kEI
         JbsOMJOxkuWC8GGSl6X4BID25YsyV5IzthOqLP5uDNxG2R4YGQaV+s6eoZLVEi5OBaBN
         +9k/Go8PYwgvOIzTSROglpJLtoCRdaN2+B0mDFwKYMDwEuraJXLryt0egI90zz5fox3+
         xp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701718395; x=1702323195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPLyZ99seCPicBCXDZB9lqIEFSMnRlWV8gcxMk/enRM=;
        b=MZ9HoEUTbOblFclb9r1bO3J4pW5XucEJP3YGLEBptHYk9SH6Ptt75pK2ykYMFdQ5Ta
         YonPPzYRrFCFIuoy6dJRutlhgVmWpNm+/y3dwc3lt8tHUnq7Lkcew76ubtU5/1nxvXGF
         7j6nWES7xFb+YXpgw8pgZHfmW04rSv3zlMYyQkC/OOXUvYhaeWsV1UzA0QStik1iGT+N
         N5G0lQI4jcpHgV1VBRe5YGOjY1F8WbDHdCGPRmZWqkyKFLauWraRdmvILYHwVyQqCZmv
         WB/e4qKai/2M4/dXoVpcqUG4Y8nD4bgabXhaTaJ/oqyDY6J0O6v90N56RdsMIRupcwfO
         udtw==
X-Gm-Message-State: AOJu0YwrIsqoauIiLrMF1pE8oQSCOeL3BWO9vkJLmw2DrijsTMR1+BAL
	3S5Xe5lRRZEVdJAErp6ZAzh8SQ==
X-Google-Smtp-Source: AGHT+IGkrKaGiFhAp7oK0f4BIQy2oFELmC3jxP+vwpzj8s/Gl4T3A6gIJhi/I7plWsz2YyH/VgUi4A==
X-Received: by 2002:a05:6602:2245:b0:7b3:5be5:fa55 with SMTP id o5-20020a056602224500b007b35be5fa55mr33072956ioo.2.1701718395387;
        Mon, 04 Dec 2023 11:33:15 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y14-20020a6be50e000000b007b35a715c92sm2857601ioc.24.2023.12.04.11.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 11:33:14 -0800 (PST)
Message-ID: <aac915ff-6726-4463-985e-9401228404ca@kernel.dk>
Date: Mon, 4 Dec 2023 12:33:13 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Content-Language: en-US
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, hch@lst.de, sagi@grimberg.me,
 asml.silence@gmail.com, Keith Busch <kbusch@kernel.org>,
 linux-security-module@vger.kernel.org
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
 <9c1ee0ee-ccae-4013-83f4-92a2af7bdf42@kernel.dk>
 <x49sf4hsrgx.fsf@segfault.usersys.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <x49sf4hsrgx.fsf@segfault.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/23 12:22 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 12/4/23 11:40 AM, Jeff Moyer wrote:
>>> Finally, as Jens mentioned, I would expect dropping priviliges to, you
>>> know, drop privileges.  I don't think a commit message is going to be
>>> enough documentation for a change like this.
>>
>> Only thing I can think of here is to cache the state in
>> task->io_uring->something, and then ensure those are invalidated
>> whenever caps change.
> 
> I looked through the capable() code, and there is no way that I could
> find to be notified of changes.

Right, what I meant is that you'd need to add an io_uring_cap_change()
or something that gets called, and that iterates the rings associated
with that task and clears the flag. Ugly...

-- 
Jens Axboe

