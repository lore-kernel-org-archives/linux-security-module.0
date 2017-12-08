From: dvyukov@google.com (Dmitry Vyukov)
Date: Fri, 8 Dec 2017 18:50:00 +0100
Subject: KASAN: slab-out-of-bounds Read in strcmp
In-Reply-To: <CAGH-KgvjP35Sz=_MO8Mcdpe06j5-z7Jh1pUwJrD+QxyuzWyQAA@mail.gmail.com>
References: <001a113f711a721c58055f052200@google.com>
	<089e08259d282c063e055f4bddbd@google.com>
	<97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
	<1512395025.20988.3.camel@tycho.nsa.gov>
	<CACT4Y+Z50TGJj8PhJczMt4zF8aMyr5586GsJ7LAmS-Bf-QkXiw@mail.gmail.com>
	<CAGH-Kgv+Nj2fpR+3SjnKJk1KMBZqqm9CwD2UAMau539nxtpU4g@mail.gmail.com>
	<CACT4Y+bKC5d135iFAP0qdU7EG+11n7HeCm2d54KwqNfCLMGrpA@mail.gmail.com>
	<CAGH-KgvjP35Sz=_MO8Mcdpe06j5-z7Jh1pUwJrD+QxyuzWyQAA@mail.gmail.com>
Message-ID: <CACT4Y+bNcwOkZXHd2-NTkh7kNB-ASyPWy+-1rvCD_UgdTB2SHg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Dec 4, 2017 at 10:10 PM, Paul Moore <pmoore@redhat.com> wrote:
>> Hi Paul,
>>
>> We are just rolling in the process. Feedback is much appreciated!
>>
>> The idea is that we need to know the title as it will appear in Linus
>> tree and in other tested trees. It's also possible to override the
>> title later, if there is any mess with it. So sending "#syz fix" as
>> soon as it is merged into any tree looks like the best option (to not
>> require you to keep in mind that you also need to do that tiny bit in
>> a month).
>>
>> Are the following changes look good to you?
>> For email footer:
>>
>> -Once a fix for this bug is committed, please reply to this email with:
>> +Once a fix for this bug is merged into any tree, reply to this email with:
>> #syz fix: exact-commit-title
>>
>> And for the https://github.com/google/syzkaller/blob/master/docs/syzbot.md page:
>>
>> to attach a fixing commit to the bug:
>> #syz fix: exact-commit-title
>> +It's enough that the commit is merged into any tree, in particular,
>> +you don't need to wait for the commit to be merged into upstream tree.
>> +syzbot only needs to know the title by which it will appear in tested trees.
>> +In case of an error or a title change, you can override the commit simply
>> +by sending another #syz fix command.
>
> That is an improvement, yes.  I might also mention that you would
> prefer if the syzkaller-bugs list is CC'd on the commands; that wasn't
> clear to me until I got a message back from syzbot just now.


Fixed with:

https://github.com/google/syzkaller/commit/2f6fb923683af1397d3d6abea0bde51a9bdcdca7
https://github.com/google/syzkaller/commit/8e1e4403ac29a60350169da5449a1497635ee13b




>>> For the record, I did see that part of the syzbot mail but I was
>>
>> Then sorry for pinging. We are trying to establish the process, and
>> some developers don't notice that part, so I just wanted to make sure.
>
> I would *strongly* suggest spending some time trying to find a
> mechanism that doesn't rely on developers needing to send special
> commands to your system to register fixes; that seems prone to failure
> if you want my honest opinion.
>
> At the very least you might consider moving the instructions to the
> top of the message.
>
>>> waiting until I merged that patch; v2 was posted late in the week and
>>> I was giving it a few days in case someone saw something
>>> objectionable.
>>
>> In such case you can do either way. You can wait, or you can post
>> commit title as soon as you have enough assurance that that's the
>> title with which it will appear in trees. We don't want to put too
>> much burden on developers. As I said, it's possible to override it
>> later, or we will notice that there is a commit that bot is waiting
>> for too long.
>>
>> Thanks
>
> --
> paul moore
> security @ redhat
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
