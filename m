Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C876C07E9B
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Jul 2021 16:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B7F613C9
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Jul 2021 16:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhGIQDC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Jul 2021 12:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232518AbhGIQC6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Jul 2021 12:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625846414;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W8zd5CeolMZZOgiP9R7Wu16S5BIqDudS+X6cBxCBcfY=;
        b=BpRWzC+aFHLMSkjOIPGpTUx1+Sl3jN1ExaJu90z5N6es1NVs8NMpbPYruaRDj0LXDe/qyq
        kwnFyIRVm9actLD4YcUuogMGHtjSKMtkX4miH8+mq/bCBBjn68i/b/z/gw/oZh2feW9i6O
        fmlgALqzaFvFz+JvgSgmHXJZbQrSMfw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-OUHPQDrZMAiD1FiZulHm9A-1; Fri, 09 Jul 2021 12:00:13 -0400
X-MC-Unique: OUHPQDrZMAiD1FiZulHm9A-1
Received: by mail-qt1-f200.google.com with SMTP id w3-20020ac80ec30000b029024e8c2383c1so6042625qti.5
        for <linux-security-module@vger.kernel.org>; Fri, 09 Jul 2021 09:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=W8zd5CeolMZZOgiP9R7Wu16S5BIqDudS+X6cBxCBcfY=;
        b=D/mY2wAge4NCBRRhGW7QZF4jynBpooU5SEnq6b9UstLKoZ9bsGQ4t3HduHr2ketLLX
         7VyGZFEee+hiU+szOXeOCuFO6KfI21tvbwrSbDaqTyo0Ir3nhBMGV5G3/5l2I+TvsCBX
         GFteeI+kEvenQINddqvSsWirglHbDrU0mdBouFLBqqe4H1Zyh3amvFrffN6F0KnQQZoY
         vVcAiRWoJ6UdO1sRkTEIPDSaW9NmS0gqFm1dEWUUm0Iim/6UJD9M4Ttw7up665Ogqp1S
         4THWYtqpg3U09qh0Cz49mysi/OG8OjZfsWeCIAw8nUtjT4UQho22dRAZaJMAYs2bdY2N
         4tjg==
X-Gm-Message-State: AOAM533bN5Kxzs32CzK+mHBY6ULrK3Fixt6mz1d1naMGrD3XbOdvvAG8
        p4KFuSAju8vEWeBoqOerIjOrz0EtenxBXMj/+HbkBVY7c+QY6sfbg9hwKFCXZRy6rkAsG9OhpMk
        et00c3iNGsEWj5IWf9lSC/FGjHjD8ea5vO+L2
X-Received: by 2002:a05:620a:14b5:: with SMTP id x21mr1254265qkj.148.1625846412889;
        Fri, 09 Jul 2021 09:00:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7fgfym/vObH9dS3BXtTYjPpC0DOawx2XrMA8j/rEnnVa/GS7s/gG7r6kSkkmhMgMhzYecxw==
X-Received: by 2002:a05:620a:14b5:: with SMTP id x21mr1253860qkj.148.1625846409623;
        Fri, 09 Jul 2021 09:00:09 -0700 (PDT)
Received: from localhost.localdomain (cpe-74-65-150-180.maine.res.rr.com. [74.65.150.180])
        by smtp.gmail.com with ESMTPSA id d8sm2623910qkk.119.2021.07.09.09.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 09:00:09 -0700 (PDT)
Reply-To: dwalsh@redhat.com
Subject: Re: [RFC PATCH v2 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     virtio-fs@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com, jack@suse.cz
References: <20210708175738.360757-1-vgoyal@redhat.com>
From:   Daniel Walsh <dwalsh@redhat.com>
Organization: Red Hat
Message-ID: <76d4a0ed-7582-cc73-a447-5f2d133c3c24@redhat.com>
Date:   Fri, 9 Jul 2021 12:00:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708175738.360757-1-vgoyal@redhat.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dwalsh@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/8/21 13:57, Vivek Goyal wrote:
> Hi,
>
> This is V2 of the patch. Posted V1 here.
>
> https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
>
> Right now we don't allow setting user.* xattrs on symlinks and special
> files at all. Initially I thought that real reason behind this
> restriction is quota limitations but from last conversation it seemed
> that real reason is that permission bits on symlink and special files
> are special and different from regular files and directories, hence
> this restriction is in place.
>
> Given it probably is not a quota issue (I tested with xfs user quota
> enabled and quota restrictions kicked in on symlink), I dropped the
> idea of allowing user.* xattr if process has CAP_SYS_RESOURCE.
>
> Instead this version of patch allows reading/writing user.* xattr
> on symlink and special files if caller is owner or priviliged (has
> CAP_FOWNER) w.r.t inode.
>
> We need this for virtiofs daemon. I also found one more user. Giuseppe,
> seems to set user.* xattr attrs on unpriviliged fuse-overlay as well
> and he ran into similar issue. So fuse-overlay should benefit from
> this change as well.
>
> Who wants to set user.* xattr on symlink/special files
> -----------------------------------------------------
>
> In virtiofs, actual file server is virtiosd daemon running on host.
> There we have a mode where xattrs can be remapped to something else.
> For example security.selinux can be remapped to
> user.virtiofsd.securit.selinux on the host.
>
> This remapping is useful when SELinux is enabled in guest and virtiofs
> as being used as rootfs. Guest and host SELinux policy might not match
> and host policy might deny security.selinux xattr setting by guest
> onto host. Or host might have SELinux disabled and in that case to
> be able to set security.selinux xattr, virtiofsd will need to have
> CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
> guest security.selinux (or other xattrs) on host to something else
> is also better from security point of view.
>
> But when we try this, we noticed that SELinux relabeling in guest
> is failing on some symlinks. When I debugged a little more, I
> came to know that "user.*" xattrs are not allowed on symlinks
> or special files.
>
> So if we allow owner (or CAP_FOWNER) to set user.* xattr, it will
> allow virtiofs to arbitrarily remap guests's xattrs to something
> else on host and that solves this SELinux issue nicely and provides
> two SELinux policies (host and guest) to co-exist nicely without
> interfering with each other.
>
> Thanks
> Vivek
>
>
> Vivek Goyal (1):
>    xattr: Allow user.* xattr on symlink and special files
>
>   fs/xattr.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
I just wanted to point out that the work Giuseppe is doing is to support 
nfs homedirs with container runtimes like Rootless Podman.


Basically fuse-overlayfs on top of NFS homedir needs to be able to use 
user xattrs to set file permissions and ownership fields to be 
represented to containers.

Currently NFS Servers do not understand User Namespace and seeing a 
client user attempting to chown to a different user, is blocked on the 
server, even though user namespace on the client allows it.  
fuse-overlay intercepts the chown from the container and writes out the 
user.Xattr the permissions and owner/group as user.Xattrs.  And all the 
server sees is the user modifying the xattrs now chowning the real UID 
of the file.


