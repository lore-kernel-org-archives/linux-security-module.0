Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3047C433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Nov 2021 01:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34FE61ABD
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Nov 2021 01:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhKQBVe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhKQBVe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Nov 2021 20:21:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826CDC061570
        for <linux-security-module@vger.kernel.org>; Tue, 16 Nov 2021 17:18:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so3179286edz.2
        for <linux-security-module@vger.kernel.org>; Tue, 16 Nov 2021 17:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6Z89lxyTX8xN6Q/IJF/I1bwjyEC+LNIBaONkeXH9tt4=;
        b=cGYiYNiVNFnxSkyaEZc4XAXlX6aPxL1xAECnlcj2miV0RjIAMFxAE69ALUKToCMBJB
         5HTYw/0jpCPLMPMpdelBU8hH6tNMvLiniYXM0JSBi2lHj75NNIeJTnpC8fQo9tj2vdAT
         z76mJF1op45SEWXzSdjBbzZ+nyPrZvojq4RvdRojc1Iec4qvJCco216cpUNKVYUHiXPV
         bIee+SKjZxDqUMXkh+0LrROzDfqyN5DMrTKu1egYpNYpkYVybmwNnWc/fUUArmFccuB8
         C+MWm5qaDpnehFPrPhRCB2VjhM4mp0uG3ao29ri0EoPyvnNVoVrX2VwXZNaPWXqiVmSb
         HYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6Z89lxyTX8xN6Q/IJF/I1bwjyEC+LNIBaONkeXH9tt4=;
        b=vAT4flXl+FL3c+QCIFirHDR/cvgfw8XPy2uuk2ZUnAZbnM77gVbJy/Cc8P6MPceIlB
         Zvx1uEKG7qv+3ZdANqwikN45q8oF0XOJnF1p/Fk3amgqVZKaASU6FNAp+MlOFIOryoFs
         2RIRw20m9bSay0hh7EmJeQHgbtCZ80jUMw/NyaVRHBnNDtqkfqPQGEvQsv7ePv1S1QtO
         uGXKEbXK9I0OMY2YhwvhMWueQN9cZVVektP+y2BYLaIjR+DXAlCeMxY3b9sXfcgeHBod
         Z6KXFD5cEKJVtEVbe0oF6bfi3u2Ijll+8XVLirsCcwKkks1itX6dF+Ot52t7Txo7Nasw
         e5Hg==
X-Gm-Message-State: AOAM530LMP810/p+XaMtvMRW3mdB93Uq5nwk1S5iml9okCEuvN3kIaKQ
        PD5Hj2ERv5G7CgIHBD1K0UIbb5pkpq8=
X-Google-Smtp-Source: ABdhPJxTIyfWNWjDf14Tq99oOxsuSvO6J+OIcIevageiMaHd0W+Wf3L5P2wUxa0mkSqxdcBe+CnLMA==
X-Received: by 2002:a17:906:dc91:: with SMTP id cs17mr16472788ejc.461.1637111914872;
        Tue, 16 Nov 2021 17:18:34 -0800 (PST)
Received: from [192.168.1.164] (mue-88-130-57-070.dsl.tropolys.de. [88.130.57.70])
        by smtp.gmail.com with ESMTPSA id j3sm8811076ejo.2.2021.11.16.17.18.34
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 17:18:34 -0800 (PST)
To:     linux-security-module@vger.kernel.org
From:   Denis Obrezkov <denisobrezkov@gmail.com>
Subject: SMACK: access is granted while smack-utils report that it shouldn't
 be
Message-ID: <3b0bd664-fbb5-0182-bc3a-89058dafc164@gmail.com>
Date:   Wed, 17 Nov 2021 02:18:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

I installed smack (enabled it in the kernel and installed smack-utils)
in my Linux From Scratch distro. I am trying to regulate access with it
but access is always granted.

I created a file and installed the labels (with attr -S -s ...), they
were attached:

echo "foobar text" > foobar

# attr -S -g SMACK64 foobar
Attribute "SMACK64" had a 8 byte value for foobar:
objlabel

# attr -S -g SMACK64EXEC /bin/cat
Attribute "SMACK64EXEC" had a 9 byte value for /bin/cat:
subjlabel

I wrote simple rules, reading is forbidden:

echo subjlabel objlabel -w--- > /sys/fs/smackfs/load2
# smackaccess subjlabel objlabel w
1
# smackaccess subjlabel objlabel r
0

but when I try to read the file I succeed:

# cat foobar
foobar text

And the relevant output in dmesg shows that the access was granted:

[ 4341.952360] audit: type=1400 audit(1637110820.839:108): lsm=SMACK
fn=smack_inode_permission action=granted subject="subjlabel"
object="objlabel" requested=r pid=427 comm="cat" name="foobar"
dev="sda1" ino=820571
[ 4341.955501] audit: type=1400 audit(1637110820.839:109): lsm=SMACK
fn=smack_file_open action=granted subject="subjlabel" object="objlabel"
requested=r pid=427 comm="cat" path="/root/foobar" dev="sda1" ino=820571
[ 4341.958411] audit: type=1400 audit(1637110820.839:110): lsm=SMACK
fn=smack_inode_getattr action=granted subject="subjlabel"
object="objlabel" requested=r pid=427 comm="cat" path="/root/foobar"
dev="sda1" ino=820571

What can be the problem?
-- 
Regards, Denis Obrezkov
