Return-Path: <SRS0=Dufg=QI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C032C282D8
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Feb 2019 21:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFED2146E
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Feb 2019 21:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak+yBn2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbfBAVT6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:19:58 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:43369 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBAVT6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Feb 2019 16:19:58 -0500
Received: by mail-pl1-f172.google.com with SMTP id gn14so3822617plb.10
        for <linux-security-module@vger.kernel.org>; Fri, 01 Feb 2019 13:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=7tJPlW4X2xQ2FOACCpsW/VxkUsOe9pu9sBX3octZfzg=;
        b=ak+yBn2gE/Uut/DCqn+jvgL9z4iJNp+GHtE775OUshO5UuwPCVVl+Fd/JTX9iJnspL
         b0a6jiDiPDuIbRpLQySklMHGSkNwQhLNg8Iu3tKVa9xEZWwtSIWjW/pjiNsZXWu7FPEM
         uuBO9s48yvSMhq4BKMKC3sDc825ZRhlnmKO/SxFuk6/GXrJa6dbfowcoIF2Xaw8IIWSa
         ZH/arMfXOGQD06HA1l3pLa2K1JW/dd+VTO4HT+1gs9aSW8RHJZ0YvrODDWwCSavs2VpU
         DVkbm0ht14IrFdnWn3Cf7Vhm45xoAwpm/oQcLeRoORMPyRmqxDArJmJBwcR7aPW3/jfv
         cK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=7tJPlW4X2xQ2FOACCpsW/VxkUsOe9pu9sBX3octZfzg=;
        b=F+uRKgFIsfgVkSgRFmEV+wRt5DYspbp2Nm/nI2j/5ncVcPx0dx0CMHUDgQ+ce6f6do
         LeGyGc+5w17hIU1w5j1MSODRkvtJ3WPWeaMO9yHsRviQUmxyFNiuOoKYNALKs8TuPeGB
         Ef/S8Lrw5Pu6i/w+65os1YAzLrIoQG8TWOcdQjO4qzhwzCMADWkiwwyK8Svy5O5ex596
         1BfXSspw1dJYVlUgUrf0qA6RT2SZe3d0p0rnAoXGVncHT9PTqQsizyiXJ4JoPG7WyQeO
         xRp583PkGq1ZVoy2/oMEZLimDeWz2mEvEuLJrWFN3Fg5j+7KGs77kEx/I4pXayZFJr9c
         Lx4Q==
X-Gm-Message-State: AJcUukfLj2x8+MNDjAZ8+Pejodgjh4j1H3ha2fJFrZs5rA5kJKuxbD/d
        HLkTNaa/3REkkFkxrusT1IheEMm5
X-Google-Smtp-Source: ALg8bN595I7oXH6XA5oLbjL85+or3CxXU2OmE6fCRoYn28oSVhG6jiKLVIw8zs9oCtY+B4HwoYnWQg==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr41885479plb.76.1549055997163;
        Fri, 01 Feb 2019 13:19:57 -0800 (PST)
Received: from JF-EN-C02V905BHTDF.tld ([12.111.169.54])
        by smtp.gmail.com with ESMTPSA id d21sm10768521pfo.162.2019.02.01.13.19.56
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 13:19:56 -0800 (PST)
To:     linux-security-module@vger.kernel.org
From:   J Freyensee <why2jjj.linux@gmail.com>
Subject: Basic all-cap/all-lower case question on Environment variables
Message-ID: <52a3fb2c-8ffb-655e-a9bc-76344b27e64f@gmail.com>
Date:   Fri, 1 Feb 2019 13:19:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I have a basic question on environment variables, that with some 
documentation I have seen in the security modules like Tomoyo I'm hoping 
this could be the right list to ask the following question.

System environment variables, like PATH, LD_LIBRARY_PATH, HOME, etc.  
Can they ever default to all lower-case in a Linux Distro, i.e., path, 
ld_library_path, home, etc?  If so, is there a mode bit, kernel 
configuration setting or sysfs file to check for this setting?

I swear I have worked on Linux systems years ago that had 'path' and 
'ld_library_path' default to lower-case, but maybe I mis-recall.

Thanks for the info in advance, regards,
Jay
