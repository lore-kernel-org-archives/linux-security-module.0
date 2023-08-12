Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2437C04A94
	for <linux-security-module@archiver.kernel.org>; Sat, 12 Aug 2023 10:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjHLKI1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 12 Aug 2023 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLKI1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 12 Aug 2023 06:08:27 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D445E2132;
        Sat, 12 Aug 2023 03:08:29 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 37CA8B8Y030980;
        Sat, 12 Aug 2023 19:08:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sat, 12 Aug 2023 19:08:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 37CA8BCE030977
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Aug 2023 19:08:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <35fb916d-7233-31a8-8d1f-e64a623de337@I-love.SAKURA.ne.jp>
Date:   Sat, 12 Aug 2023 19:08:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] audit: add task history record
Content-Language: en-US
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <ZNZ082CR0oLfuiqo@madcap2.tricolour.ca>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZNZ082CR0oLfuiqo@madcap2.tricolour.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/12 2:50, Richard Guy Briggs wrote:
> On 2023-08-11 19:58, Tetsuo Handa wrote:
>> When an unexpected system event occurs, the administrator may want to
>> identify which application triggered the event. For example, unexpected
>> process termination is still a real concern enough to write articles
>> like https://access.redhat.com/solutions/165993 .
>>
>> This patch adds a record which emits TOMOYO-like task history information
>> into the audit logs for better understanding of unexpected system events.
>>
>>   type=UNKNOWN[1340] msg=audit(1691750738.271:108): history="name=swapper/0;pid=1;start=20230811194329=>name=init;pid=1;start=20230811194343=>name=systemd;pid=1;start=20230811194439=>name=sshd;pid=3660;start=20230811104504=>name=sshd;pid=3767;start=20230811104535"
>>
>> To be able to avoid bloating audit log files due to this information, this
>> patch uses audit_history= kernel command line parameter that controls max
>> length of history in bytes (default is 1024, and setting to 0 disables
>> recording and emitting).
> 
> The record length limit is just below 8k.  Is it reasonable to set the
> default at 4k and cap it around 7.5k to be safe?

Below will do it. (I though default at 0 might be better...)

+static unsigned int audit_history_size __ro_after_init = 4096;
+char init_task_audit_history[7680];
+static int __init audit_history_setup(char *str)
+{
+	unsigned int size;
+
+	if (kstrtouint(str, 10, &size))
+		return -EINVAL;
+	if (size > sizeof(init_task_audit_history))
+		size = sizeof(init_task_audit_history);
+	audit_history_size = size;
+	return 0;
+}

> 
> Is proctitle also useful here?  It contains the full command line, but
> is influencible by userspace.

Full pathname is max 4096 bytes. But full command line effectively has no
limit, which might become very long. Shouldn't full command line arguments
be retrieved from execve()'s argv[] record? Since this history information
includes timestamp of execve(), also recording execve() requests will allow
administrators to find the full command line.

>> Unlike execve()'s argv record, records in this history information is
>> emitted as one string in order to reduce bloat of the audit log files.
>> This information can be split into an array using => as the tokenizer.
>> But don't expect that you can compare array elements throughout the whole
>> audit logs by splitting into an array, for old records get removed from
>> history when history became too long to append the newest record. This
>> history information is meant to be interpreted by humans rather than be
>> analyzed by programs.
> 
> You say this isn't intended to be analysed by programs, but we all know
> it will inevitably be attempted...  Would any of the descendants of
> audit_log_untrustedstring() be of use, in particular
> audit_string_contains_control()

I couldn't catch what you are suggesting. Are you suggesting something like

  type=UNKNOWN[1340] msg=audit(1691750738.271:108):
    n[$n]="swapper/0" n[$n+1]="init" n[$n+2]="systemd" n[$n+3]="sshd" n[$n+4]="sshd"
    p[$n]=1 p[$n+1]=1 p[$n+2]=1 p[$n+3]=3660 p[$n+4]=3767
    s[$n]=20230811194329 s[$n+1]=20230811194343 s[$n+2]=20230811194439 s[$n+3]=20230811104504 s[$n+4]=20230811104535

so that value for n[$n] is escaped only when control characters are in use?

