From: tixxdz@gmail.com (Djalal Harouni)
Date: Fri, 31 Mar 2017 13:26:43 +0200
Subject: [PATCH RFC 0/4] proc: support multiple separate proc instances
	per pidnamespace
In-Reply-To: <20170330221649.GB13761@comp-core-i7-2640m-0182e6>
References: <1490887379-25880-1-git-send-email-tixxdz@gmail.com>
	<20170330221649.GB13761@comp-core-i7-2640m-0182e6>
Message-ID: <CAEiveUe4ztp+gjw8kgZ55vaLr0Zc0R5vG0XWYvZhugoH0jHS6A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 31, 2017 at 12:16 AM, Alexey Gladkov
<gladkov.alexey@gmail.com> wrote:
> On Thu, Mar 30, 2017 at 05:22:55PM +0200, Djalal Harouni wrote:
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
>>   Size: 0             Blocks: 0          IO Block: 1024   regular empty file
>> Device: 4h/4d Inode: 4026532046  Links: 1
>>
>> $ stat /test3/slabinfo
>>
>>   File: ?/test3/slabinfo?
>>   Size: 0             Blocks: 0          IO Block: 1024   regular empty file
>> Device: 4h/4d Inode: 4026532046  Links: 1
>>
>>
>> After:
>> $ stat /proc/slabinfo
>>
>>   File: ?/proc/slabinfo?
>>   Size: 0             Blocks: 0          IO Block: 1024   regular empty file
>> Device: 4h/4d Inode: 4026532046  Links: 1
>>
>> $ stat /test3/slabinfo
>>
>>   File: ?/test3/slabinfo?
>>   Size: 0             Blocks: 0          IO Block: 1024   regular empty file
>> Device: 31h/49d       Inode: 4026532046  Links: 1
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
> Multiple mnt_root's lead us to significant memory costs for storing dentry
> of tasks. I mean what we will get as many copies of the tasks dentry as many
> times we have mounted the procfs with 'unshare' flag. No?

With current implementation, that's true. However I think that we
should not sacrifice usage for optimization, currently it is
practically impossible to improve procfs, support new options or make
use of the current ones without affecting other procfs mounts. Andy
also suggested to have a mini-proc without non-pid stuff inside, and
without a new disconnected instance, new mounts or bind mounts may
expose the non-pid stuff.

Also we can improve this, right now it is not implemented but we may
can change how we do lookups, instead of doing a ptrace task after
instantiating a pid dentry we may do a ptrace permission check on task
there then create its related proc inode. With this all new procfs
instances with hidepid option set, will only have dentries of tasks
that the caller can ptrace. Also there is already the code to flush
the related task when it dies, tough, it needs further testing.

Also as with tmpfs where inodes are accounted by the memory
controller, I'm not sure if it's possible to account the same in
procfs during the first access ?

I don't see a better way to solve the current procfs problems that we
face or how to modernize it and add new options... in the end users
can always chose to use it or not.

-- 
tixxdz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
