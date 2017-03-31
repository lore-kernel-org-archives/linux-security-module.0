From: tixxdz@gmail.com (Djalal Harouni)
Date: Fri, 31 Mar 2017 13:45:54 +0200
Subject: [PATCH RFC 0/4] proc: support multiple separate proc instances
	per pidnamespace
In-Reply-To: <CALCETrWooKTtViVh4ik9e-3nLs3NET9wptgxhjS9V499sfUJQA@mail.gmail.com>
References: <1490887379-25880-1-git-send-email-tixxdz@gmail.com>
	<CALCETrWooKTtViVh4ik9e-3nLs3NET9wptgxhjS9V499sfUJQA@mail.gmail.com>
Message-ID: <CAEiveUdtJ5WojbqsXhfq2bS8ZN3zMzr2o8zXf1aO26ZaPBNuzw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Mar 30, 2017 at 9:12 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Thu, Mar 30, 2017 at 8:22 AM, Djalal Harouni <tixxdz@gmail.com> wrote:
>> Hi,
>>
>> This RFC can be applied on top of Linus' tree 89970a04d7
>>
>> This RFC implements support for multiple separate proc instances inside
>> the same pid namespace. This allows to solve lot of problems that
>> today's use case face.
>>
>> Historically procfs was tied to pid namespaces, and mount options were
>> propagated to all other procfs instances in the same pid namespace. This
>> solved several use cases in that time. However today we face new
>> problems, there are mutliple container implementations there, some of
>> them want to hide pid entries, others want to hide non-pid entries,
>> others want to have sysctlfs, others want to share pid namespace with
>> private procfs mounts. All these with current implementation won't work
>> since all options will be propagated to all procfs mounts.
>>
>> This series allow to have new instances of procfs per pid namespace where
>> each instance can have its own mount option inside the same pid namespace.
>> This was also suggested by Andy Lutomirski.
>>
>>
>> Now:
>> $ sudo mount -t proc -o unshare,hidepid=2 none /test
>>
>> The option 'unshare' will allow to mount a new instance of procfs inside
>> the same pid namespace.
>>
>> Before:
>> $ stat /proc/slabinfo
>>
>>   File: ?/proc/slabinfo?
>>   Size: 0               Blocks: 0          IO Block: 1024   regular empty file
>> Device: 4h/4d   Inode: 4026532046  Links: 1
>>
>> $ stat /test3/slabinfo
>>
>>   File: ?/test3/slabinfo?
>>   Size: 0               Blocks: 0          IO Block: 1024   regular empty file
>> Device: 4h/4d   Inode: 4026532046  Links: 1
>>
>>
>> After:
>> $ stat /proc/slabinfo
>>
>>   File: ?/proc/slabinfo?
>>   Size: 0               Blocks: 0          IO Block: 1024   regular empty file
>> Device: 4h/4d   Inode: 4026532046  Links: 1
>>
>> $ stat /test3/slabinfo
>>
>>   File: ?/test3/slabinfo?
>>   Size: 0               Blocks: 0          IO Block: 1024   regular empty file
>> Device: 31h/49d Inode: 4026532046  Links: 1
>>
>>
>> Any better name for the option 'unshare' ? suggestions ?
>>
>> I was going to use 'version=2' but then this may sound more like a
>> proc2 fs which currently impossible to implement since it will share
>> locks with the old proc.
>>
>>
>> Al, Eric any comments please ?
>
> I like the concept, except that I think it would be nice to avoid
> needing 'unshare', perhaps by making unsharing the default and making
> hidepid work backwards compatibly if needed.

Of course I can update, but as said lot of stuff may already depend on
the behaviour of procfs mount options, and the device ID inside same
pid namespace where is it is always the same ID. With this change we
will have different IDs inside same pid namespace, and I don't have
the knowledge to predict if something will break. I remember you said
that we may update stat() to show same ID but I really don't know if
that's a good idea, what if userspace now tries to check if these are
two separate proc mounts ? also maybe there is third party kernel code
that does something with these device IDs ?

For the namespace introspection, Eric suggested that we may stat /proc
before stating /proc/pid/ns/x , however he also concluded that some
security or other obscure stuff may break! I basically don't have the
resources nor the knowledge to predict what errors may come due to
changing the default behaviour of procfs. From my position it is
better to introduce a new option for it so users are warned. Is this
reasonable ? or do we have to make it default ?

Thanks!

-- 
tixxdz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
