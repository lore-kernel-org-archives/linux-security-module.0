From: dvyukov@google.com (Dmitry Vyukov)
Date: Sun, 2 Sep 2018 06:33:56 +0200
Subject: WARNING in apparmor_secid_to_secctx
In-Reply-To: <45dda774-fd57-3e60-fb67-ad855f2360c9@canonical.com>
References: <000000000000c178e305749daba4@google.com>
	<45dda774-fd57-3e60-fb67-ad855f2360c9@canonical.com>
Message-ID: <CACT4Y+Za_M8yQ9j0aUDyZ2rrgJtNHuzeFf3dwmeL5kyb3T5UBQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Sep 1, 2018 at 11:18 AM, John Johansen
<john.johansen@canonical.com> wrote:
> On 08/29/2018 07:17 PM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>> dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+21016130b0580a9de3b5 at syzkaller.appspotmail.com
>>
>
> << snip >>
>
> Patch sent directly to syzbot for testing

Hi John,

What do you mean? syzbot has not received any test requests for this,
and it would reply within half an hour or so. Where is that patch?
