
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	59013103          	ld	sp,1424(sp) # 8000b590 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	54c060ef          	jal	ra,80006568 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv14supervisorTrapEv>:
.align 4
.global _ZN5Riscv14supervisorTrapEv
.type _ZN5Riscv14supervisorTrapEv, @function
_ZN5Riscv14supervisorTrapEv:
    # push all registers to stack
    addi sp, sp, -256
    80001020:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001024:	00013023          	sd	zero,0(sp)
    80001028:	00113423          	sd	ra,8(sp)
    8000102c:	00213823          	sd	sp,16(sp)
    80001030:	00313c23          	sd	gp,24(sp)
    80001034:	02413023          	sd	tp,32(sp)
    80001038:	02513423          	sd	t0,40(sp)
    8000103c:	02613823          	sd	t1,48(sp)
    80001040:	02713c23          	sd	t2,56(sp)
    80001044:	04813023          	sd	s0,64(sp)
    80001048:	04913423          	sd	s1,72(sp)
    8000104c:	04a13823          	sd	a0,80(sp)
    80001050:	04b13c23          	sd	a1,88(sp)
    80001054:	06c13023          	sd	a2,96(sp)
    80001058:	06d13423          	sd	a3,104(sp)
    8000105c:	06e13823          	sd	a4,112(sp)
    80001060:	06f13c23          	sd	a5,120(sp)
    80001064:	09013023          	sd	a6,128(sp)
    80001068:	09113423          	sd	a7,136(sp)
    8000106c:	09213823          	sd	s2,144(sp)
    80001070:	09313c23          	sd	s3,152(sp)
    80001074:	0b413023          	sd	s4,160(sp)
    80001078:	0b513423          	sd	s5,168(sp)
    8000107c:	0b613823          	sd	s6,176(sp)
    80001080:	0b713c23          	sd	s7,184(sp)
    80001084:	0d813023          	sd	s8,192(sp)
    80001088:	0d913423          	sd	s9,200(sp)
    8000108c:	0da13823          	sd	s10,208(sp)
    80001090:	0db13c23          	sd	s11,216(sp)
    80001094:	0fc13023          	sd	t3,224(sp)
    80001098:	0fd13423          	sd	t4,232(sp)
    8000109c:	0fe13823          	sd	t5,240(sp)
    800010a0:	0ff13c23          	sd	t6,248(sp)

    call _ZN5Riscv20handleSupervisorTrapEv
    800010a4:	4c8040ef          	jal	ra,8000556c <_ZN5Riscv20handleSupervisorTrapEv>

    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010a8:	00013003          	ld	zero,0(sp)
    800010ac:	00813083          	ld	ra,8(sp)
    800010b0:	01013103          	ld	sp,16(sp)
    800010b4:	01813183          	ld	gp,24(sp)
    800010b8:	02013203          	ld	tp,32(sp)
    800010bc:	02813283          	ld	t0,40(sp)
    800010c0:	03013303          	ld	t1,48(sp)
    800010c4:	03813383          	ld	t2,56(sp)
    800010c8:	04013403          	ld	s0,64(sp)
    800010cc:	04813483          	ld	s1,72(sp)
    800010d0:	05013503          	ld	a0,80(sp)
    800010d4:	05813583          	ld	a1,88(sp)
    800010d8:	06013603          	ld	a2,96(sp)
    800010dc:	06813683          	ld	a3,104(sp)
    800010e0:	07013703          	ld	a4,112(sp)
    800010e4:	07813783          	ld	a5,120(sp)
    800010e8:	08013803          	ld	a6,128(sp)
    800010ec:	08813883          	ld	a7,136(sp)
    800010f0:	09013903          	ld	s2,144(sp)
    800010f4:	09813983          	ld	s3,152(sp)
    800010f8:	0a013a03          	ld	s4,160(sp)
    800010fc:	0a813a83          	ld	s5,168(sp)
    80001100:	0b013b03          	ld	s6,176(sp)
    80001104:	0b813b83          	ld	s7,184(sp)
    80001108:	0c013c03          	ld	s8,192(sp)
    8000110c:	0c813c83          	ld	s9,200(sp)
    80001110:	0d013d03          	ld	s10,208(sp)
    80001114:	0d813d83          	ld	s11,216(sp)
    80001118:	0e013e03          	ld	t3,224(sp)
    8000111c:	0e813e83          	ld	t4,232(sp)
    80001120:	0f013f03          	ld	t5,240(sp)
    80001124:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001128:	10010113          	addi	sp,sp,256

    sret
    8000112c:	10200073          	sret

0000000080001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0)
    80001130:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001134:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001138:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000113c:	0085b103          	ld	sp,8(a1)

    80001140:	00008067          	ret

0000000080001144 <_ZN5Riscv13pushRegistersEv>:
.global _ZN5Riscv13pushRegistersEv
.type _ZN5Riscv13pushRegistersEv, @function
_ZN5Riscv13pushRegistersEv:
    addi sp, sp, -256
    80001144:	f0010113          	addi	sp,sp,-256
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001148:	00313c23          	sd	gp,24(sp)
    8000114c:	02413023          	sd	tp,32(sp)
    80001150:	02513423          	sd	t0,40(sp)
    80001154:	02613823          	sd	t1,48(sp)
    80001158:	02713c23          	sd	t2,56(sp)
    8000115c:	04813023          	sd	s0,64(sp)
    80001160:	04913423          	sd	s1,72(sp)
    80001164:	04a13823          	sd	a0,80(sp)
    80001168:	04b13c23          	sd	a1,88(sp)
    8000116c:	06c13023          	sd	a2,96(sp)
    80001170:	06d13423          	sd	a3,104(sp)
    80001174:	06e13823          	sd	a4,112(sp)
    80001178:	06f13c23          	sd	a5,120(sp)
    8000117c:	09013023          	sd	a6,128(sp)
    80001180:	09113423          	sd	a7,136(sp)
    80001184:	09213823          	sd	s2,144(sp)
    80001188:	09313c23          	sd	s3,152(sp)
    8000118c:	0b413023          	sd	s4,160(sp)
    80001190:	0b513423          	sd	s5,168(sp)
    80001194:	0b613823          	sd	s6,176(sp)
    80001198:	0b713c23          	sd	s7,184(sp)
    8000119c:	0d813023          	sd	s8,192(sp)
    800011a0:	0d913423          	sd	s9,200(sp)
    800011a4:	0da13823          	sd	s10,208(sp)
    800011a8:	0db13c23          	sd	s11,216(sp)
    800011ac:	0fc13023          	sd	t3,224(sp)
    800011b0:	0fd13423          	sd	t4,232(sp)
    800011b4:	0fe13823          	sd	t5,240(sp)
    800011b8:	0ff13c23          	sd	t6,248(sp)
    ret
    800011bc:	00008067          	ret

00000000800011c0 <_ZN5Riscv12popRegistersEv>:
.global _ZN5Riscv12popRegistersEv
.type _ZN5Riscv12popRegistersEv, @function
_ZN5Riscv12popRegistersEv:
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800011c0:	01813183          	ld	gp,24(sp)
    800011c4:	02013203          	ld	tp,32(sp)
    800011c8:	02813283          	ld	t0,40(sp)
    800011cc:	03013303          	ld	t1,48(sp)
    800011d0:	03813383          	ld	t2,56(sp)
    800011d4:	04013403          	ld	s0,64(sp)
    800011d8:	04813483          	ld	s1,72(sp)
    800011dc:	05013503          	ld	a0,80(sp)
    800011e0:	05813583          	ld	a1,88(sp)
    800011e4:	06013603          	ld	a2,96(sp)
    800011e8:	06813683          	ld	a3,104(sp)
    800011ec:	07013703          	ld	a4,112(sp)
    800011f0:	07813783          	ld	a5,120(sp)
    800011f4:	08013803          	ld	a6,128(sp)
    800011f8:	08813883          	ld	a7,136(sp)
    800011fc:	09013903          	ld	s2,144(sp)
    80001200:	09813983          	ld	s3,152(sp)
    80001204:	0a013a03          	ld	s4,160(sp)
    80001208:	0a813a83          	ld	s5,168(sp)
    8000120c:	0b013b03          	ld	s6,176(sp)
    80001210:	0b813b83          	ld	s7,184(sp)
    80001214:	0c013c03          	ld	s8,192(sp)
    80001218:	0c813c83          	ld	s9,200(sp)
    8000121c:	0d013d03          	ld	s10,208(sp)
    80001220:	0d813d83          	ld	s11,216(sp)
    80001224:	0e013e03          	ld	t3,224(sp)
    80001228:	0e813e83          	ld	t4,232(sp)
    8000122c:	0f013f03          	ld	t5,240(sp)
    80001230:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001234:	10010113          	addi	sp,sp,256
    ret
    80001238:	00008067          	ret

000000008000123c <_ZL9sleepyRunPv>:

#include "printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    8000123c:	fe010113          	addi	sp,sp,-32
    80001240:	00113c23          	sd	ra,24(sp)
    80001244:	00813823          	sd	s0,16(sp)
    80001248:	00913423          	sd	s1,8(sp)
    8000124c:	01213023          	sd	s2,0(sp)
    80001250:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80001254:	00053903          	ld	s2,0(a0)
    int i = 6;
    80001258:	00600493          	li	s1,6
    while (--i > 0) {
    8000125c:	fff4849b          	addiw	s1,s1,-1
    80001260:	04905463          	blez	s1,800012a8 <_ZL9sleepyRunPv+0x6c>
        printString("Hello ");
    80001264:	00008517          	auipc	a0,0x8
    80001268:	dbc50513          	addi	a0,a0,-580 # 80009020 <CONSOLE_STATUS+0x10>
    8000126c:	00002097          	auipc	ra,0x2
    80001270:	27c080e7          	jalr	636(ra) # 800034e8 <_Z11printStringPKc>
        printInt(sleep_time);
    80001274:	00000613          	li	a2,0
    80001278:	00a00593          	li	a1,10
    8000127c:	0009051b          	sext.w	a0,s2
    80001280:	00002097          	auipc	ra,0x2
    80001284:	414080e7          	jalr	1044(ra) # 80003694 <_Z8printIntiii>
        printString(" !\n");
    80001288:	00008517          	auipc	a0,0x8
    8000128c:	da050513          	addi	a0,a0,-608 # 80009028 <CONSOLE_STATUS+0x18>
    80001290:	00002097          	auipc	ra,0x2
    80001294:	258080e7          	jalr	600(ra) # 800034e8 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80001298:	00090513          	mv	a0,s2
    8000129c:	00005097          	auipc	ra,0x5
    800012a0:	b10080e7          	jalr	-1264(ra) # 80005dac <_Z10time_sleepm>
    while (--i > 0) {
    800012a4:	fb9ff06f          	j	8000125c <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    800012a8:	00a00793          	li	a5,10
    800012ac:	02f95933          	divu	s2,s2,a5
    800012b0:	fff90913          	addi	s2,s2,-1
    800012b4:	0000a797          	auipc	a5,0xa
    800012b8:	30c78793          	addi	a5,a5,780 # 8000b5c0 <_ZL8finished>
    800012bc:	01278933          	add	s2,a5,s2
    800012c0:	00100793          	li	a5,1
    800012c4:	00f90023          	sb	a5,0(s2)
}
    800012c8:	01813083          	ld	ra,24(sp)
    800012cc:	01013403          	ld	s0,16(sp)
    800012d0:	00813483          	ld	s1,8(sp)
    800012d4:	00013903          	ld	s2,0(sp)
    800012d8:	02010113          	addi	sp,sp,32
    800012dc:	00008067          	ret

00000000800012e0 <_Z12testSleepingv>:

void testSleeping() {
    800012e0:	fc010113          	addi	sp,sp,-64
    800012e4:	02113c23          	sd	ra,56(sp)
    800012e8:	02813823          	sd	s0,48(sp)
    800012ec:	02913423          	sd	s1,40(sp)
    800012f0:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    800012f4:	00a00793          	li	a5,10
    800012f8:	fcf43823          	sd	a5,-48(s0)
    800012fc:	01400793          	li	a5,20
    80001300:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80001304:	00000493          	li	s1,0
    80001308:	00100793          	li	a5,1
    8000130c:	0297c863          	blt	a5,s1,8000133c <_Z12testSleepingv+0x5c>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80001310:	00349513          	slli	a0,s1,0x3
    80001314:	fd040793          	addi	a5,s0,-48
    80001318:	00a78633          	add	a2,a5,a0
    8000131c:	00000597          	auipc	a1,0x0
    80001320:	f2058593          	addi	a1,a1,-224 # 8000123c <_ZL9sleepyRunPv>
    80001324:	fc040793          	addi	a5,s0,-64
    80001328:	00a78533          	add	a0,a5,a0
    8000132c:	00005097          	auipc	ra,0x5
    80001330:	9ac080e7          	jalr	-1620(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80001334:	0014849b          	addiw	s1,s1,1
    80001338:	fd1ff06f          	j	80001308 <_Z12testSleepingv+0x28>
    }

    while (!(finished[0] && finished[1])) {}
    8000133c:	0000a797          	auipc	a5,0xa
    80001340:	28478793          	addi	a5,a5,644 # 8000b5c0 <_ZL8finished>
    80001344:	0007c783          	lbu	a5,0(a5)
    80001348:	0ff7f793          	andi	a5,a5,255
    8000134c:	fe0788e3          	beqz	a5,8000133c <_Z12testSleepingv+0x5c>
    80001350:	0000a797          	auipc	a5,0xa
    80001354:	27078793          	addi	a5,a5,624 # 8000b5c0 <_ZL8finished>
    80001358:	0017c783          	lbu	a5,1(a5)
    8000135c:	0ff7f793          	andi	a5,a5,255
    80001360:	fc078ee3          	beqz	a5,8000133c <_Z12testSleepingv+0x5c>
}
    80001364:	03813083          	ld	ra,56(sp)
    80001368:	03013403          	ld	s0,48(sp)
    8000136c:	02813483          	ld	s1,40(sp)
    80001370:	04010113          	addi	sp,sp,64
    80001374:	00008067          	ret

0000000080001378 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80001378:	fd010113          	addi	sp,sp,-48
    8000137c:	02113423          	sd	ra,40(sp)
    80001380:	02813023          	sd	s0,32(sp)
    80001384:	00913c23          	sd	s1,24(sp)
    80001388:	01213823          	sd	s2,16(sp)
    8000138c:	01313423          	sd	s3,8(sp)
    80001390:	03010413          	addi	s0,sp,48
    80001394:	00050993          	mv	s3,a0
    80001398:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    8000139c:	00000913          	li	s2,0
    800013a0:	00c0006f          	j	800013ac <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    800013a4:	00004097          	auipc	ra,0x4
    800013a8:	838080e7          	jalr	-1992(ra) # 80004bdc <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    800013ac:	00005097          	auipc	ra,0x5
    800013b0:	b84080e7          	jalr	-1148(ra) # 80005f30 <_Z4getcv>
    800013b4:	0005059b          	sext.w	a1,a0
    800013b8:	01b00793          	li	a5,27
    800013bc:	02f58a63          	beq	a1,a5,800013f0 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    800013c0:	0084b503          	ld	a0,8(s1)
    800013c4:	00003097          	auipc	ra,0x3
    800013c8:	870080e7          	jalr	-1936(ra) # 80003c34 <_ZN9BufferCPP3putEi>
        i++;
    800013cc:	0019079b          	addiw	a5,s2,1
    800013d0:	0007891b          	sext.w	s2,a5
        if (i % (10 * data->id) == 0) {
    800013d4:	0004a683          	lw	a3,0(s1)
    800013d8:	0026971b          	slliw	a4,a3,0x2
    800013dc:	00d7073b          	addw	a4,a4,a3
    800013e0:	0017169b          	slliw	a3,a4,0x1
    800013e4:	02d7e7bb          	remw	a5,a5,a3
    800013e8:	fc0792e3          	bnez	a5,800013ac <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    800013ec:	fb9ff06f          	j	800013a4 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    800013f0:	00100793          	li	a5,1
    800013f4:	0000a717          	auipc	a4,0xa
    800013f8:	1cf72a23          	sw	a5,468(a4) # 8000b5c8 <_ZL9threadEnd>
    td->buffer->put('!');
    800013fc:	0209b783          	ld	a5,32(s3)
    80001400:	02100593          	li	a1,33
    80001404:	0087b503          	ld	a0,8(a5)
    80001408:	00003097          	auipc	ra,0x3
    8000140c:	82c080e7          	jalr	-2004(ra) # 80003c34 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80001410:	0104b503          	ld	a0,16(s1)
    80001414:	00004097          	auipc	ra,0x4
    80001418:	8f4080e7          	jalr	-1804(ra) # 80004d08 <_ZN9Semaphore6signalEv>
}
    8000141c:	02813083          	ld	ra,40(sp)
    80001420:	02013403          	ld	s0,32(sp)
    80001424:	01813483          	ld	s1,24(sp)
    80001428:	01013903          	ld	s2,16(sp)
    8000142c:	00813983          	ld	s3,8(sp)
    80001430:	03010113          	addi	sp,sp,48
    80001434:	00008067          	ret

0000000080001438 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80001438:	fe010113          	addi	sp,sp,-32
    8000143c:	00113c23          	sd	ra,24(sp)
    80001440:	00813823          	sd	s0,16(sp)
    80001444:	00913423          	sd	s1,8(sp)
    80001448:	01213023          	sd	s2,0(sp)
    8000144c:	02010413          	addi	s0,sp,32
    80001450:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80001454:	00000913          	li	s2,0
    80001458:	00c0006f          	j	80001464 <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    8000145c:	00003097          	auipc	ra,0x3
    80001460:	780080e7          	jalr	1920(ra) # 80004bdc <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80001464:	0000a797          	auipc	a5,0xa
    80001468:	16478793          	addi	a5,a5,356 # 8000b5c8 <_ZL9threadEnd>
    8000146c:	0007a783          	lw	a5,0(a5)
    80001470:	0007879b          	sext.w	a5,a5
    80001474:	02079e63          	bnez	a5,800014b0 <_ZN12ProducerSync8producerEPv+0x78>
        data->buffer->put(data->id + '0');
    80001478:	0004a583          	lw	a1,0(s1)
    8000147c:	0305859b          	addiw	a1,a1,48
    80001480:	0084b503          	ld	a0,8(s1)
    80001484:	00002097          	auipc	ra,0x2
    80001488:	7b0080e7          	jalr	1968(ra) # 80003c34 <_ZN9BufferCPP3putEi>
        i++;
    8000148c:	0019079b          	addiw	a5,s2,1
    80001490:	0007891b          	sext.w	s2,a5
        if (i % (10 * data->id) == 0) {
    80001494:	0004a683          	lw	a3,0(s1)
    80001498:	0026971b          	slliw	a4,a3,0x2
    8000149c:	00d7073b          	addw	a4,a4,a3
    800014a0:	0017169b          	slliw	a3,a4,0x1
    800014a4:	02d7e7bb          	remw	a5,a5,a3
    800014a8:	fa079ee3          	bnez	a5,80001464 <_ZN12ProducerSync8producerEPv+0x2c>
    800014ac:	fb1ff06f          	j	8000145c <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    800014b0:	0104b503          	ld	a0,16(s1)
    800014b4:	00004097          	auipc	ra,0x4
    800014b8:	854080e7          	jalr	-1964(ra) # 80004d08 <_ZN9Semaphore6signalEv>
}
    800014bc:	01813083          	ld	ra,24(sp)
    800014c0:	01013403          	ld	s0,16(sp)
    800014c4:	00813483          	ld	s1,8(sp)
    800014c8:	00013903          	ld	s2,0(sp)
    800014cc:	02010113          	addi	sp,sp,32
    800014d0:	00008067          	ret

00000000800014d4 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    800014d4:	fd010113          	addi	sp,sp,-48
    800014d8:	02113423          	sd	ra,40(sp)
    800014dc:	02813023          	sd	s0,32(sp)
    800014e0:	00913c23          	sd	s1,24(sp)
    800014e4:	01213823          	sd	s2,16(sp)
    800014e8:	01313423          	sd	s3,8(sp)
    800014ec:	01413023          	sd	s4,0(sp)
    800014f0:	03010413          	addi	s0,sp,48
    800014f4:	00050993          	mv	s3,a0
    800014f8:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800014fc:	00000a13          	li	s4,0
    80001500:	01c0006f          	j	8000151c <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80001504:	00003097          	auipc	ra,0x3
    80001508:	6d8080e7          	jalr	1752(ra) # 80004bdc <_ZN6Thread8dispatchEv>
    8000150c:	0580006f          	j	80001564 <_ZN12ConsumerSync8consumerEPv+0x90>
        }

        if (i % 80 == 0) {
            putc('\n');
    80001510:	00a00513          	li	a0,10
    80001514:	00005097          	auipc	ra,0x5
    80001518:	a4c080e7          	jalr	-1460(ra) # 80005f60 <_Z4putcc>
    while (!threadEnd) {
    8000151c:	0000a797          	auipc	a5,0xa
    80001520:	0ac78793          	addi	a5,a5,172 # 8000b5c8 <_ZL9threadEnd>
    80001524:	0007a783          	lw	a5,0(a5)
    80001528:	0007879b          	sext.w	a5,a5
    8000152c:	04079463          	bnez	a5,80001574 <_ZN12ConsumerSync8consumerEPv+0xa0>
        int key = data->buffer->get();
    80001530:	00893503          	ld	a0,8(s2)
    80001534:	00002097          	auipc	ra,0x2
    80001538:	790080e7          	jalr	1936(ra) # 80003cc4 <_ZN9BufferCPP3getEv>
        i++;
    8000153c:	001a049b          	addiw	s1,s4,1
    80001540:	00048a1b          	sext.w	s4,s1
        putc(key);
    80001544:	0ff57513          	andi	a0,a0,255
    80001548:	00005097          	auipc	ra,0x5
    8000154c:	a18080e7          	jalr	-1512(ra) # 80005f60 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80001550:	00092703          	lw	a4,0(s2)
    80001554:	0027179b          	slliw	a5,a4,0x2
    80001558:	00e787bb          	addw	a5,a5,a4
    8000155c:	02f4e7bb          	remw	a5,s1,a5
    80001560:	fa0782e3          	beqz	a5,80001504 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80001564:	05000793          	li	a5,80
    80001568:	02f4e4bb          	remw	s1,s1,a5
    8000156c:	fa0498e3          	bnez	s1,8000151c <_ZN12ConsumerSync8consumerEPv+0x48>
    80001570:	fa1ff06f          	j	80001510 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
    80001574:	0209b783          	ld	a5,32(s3)
    80001578:	0087b503          	ld	a0,8(a5)
    8000157c:	00002097          	auipc	ra,0x2
    80001580:	7d4080e7          	jalr	2004(ra) # 80003d50 <_ZN9BufferCPP6getCntEv>
    80001584:	02a05263          	blez	a0,800015a8 <_ZN12ConsumerSync8consumerEPv+0xd4>
        int key = td->buffer->get();
    80001588:	0209b783          	ld	a5,32(s3)
    8000158c:	0087b503          	ld	a0,8(a5)
    80001590:	00002097          	auipc	ra,0x2
    80001594:	734080e7          	jalr	1844(ra) # 80003cc4 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80001598:	0ff57513          	andi	a0,a0,255
    8000159c:	00004097          	auipc	ra,0x4
    800015a0:	844080e7          	jalr	-1980(ra) # 80004de0 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    800015a4:	fd1ff06f          	j	80001574 <_ZN12ConsumerSync8consumerEPv+0xa0>
    }

    data->wait->signal();
    800015a8:	01093503          	ld	a0,16(s2)
    800015ac:	00003097          	auipc	ra,0x3
    800015b0:	75c080e7          	jalr	1884(ra) # 80004d08 <_ZN9Semaphore6signalEv>
}
    800015b4:	02813083          	ld	ra,40(sp)
    800015b8:	02013403          	ld	s0,32(sp)
    800015bc:	01813483          	ld	s1,24(sp)
    800015c0:	01013903          	ld	s2,16(sp)
    800015c4:	00813983          	ld	s3,8(sp)
    800015c8:	00013a03          	ld	s4,0(sp)
    800015cc:	03010113          	addi	sp,sp,48
    800015d0:	00008067          	ret

00000000800015d4 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    800015d4:	f8010113          	addi	sp,sp,-128
    800015d8:	06113c23          	sd	ra,120(sp)
    800015dc:	06813823          	sd	s0,112(sp)
    800015e0:	06913423          	sd	s1,104(sp)
    800015e4:	07213023          	sd	s2,96(sp)
    800015e8:	05313c23          	sd	s3,88(sp)
    800015ec:	05413823          	sd	s4,80(sp)
    800015f0:	05513423          	sd	s5,72(sp)
    800015f4:	05613023          	sd	s6,64(sp)
    800015f8:	03713c23          	sd	s7,56(sp)
    800015fc:	03813823          	sd	s8,48(sp)
    80001600:	03913423          	sd	s9,40(sp)
    80001604:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80001608:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    8000160c:	00008517          	auipc	a0,0x8
    80001610:	a9c50513          	addi	a0,a0,-1380 # 800090a8 <_ZTV12ConsumerSync+0x28>
    80001614:	00002097          	auipc	ra,0x2
    80001618:	ed4080e7          	jalr	-300(ra) # 800034e8 <_Z11printStringPKc>
    getString(input, 30);
    8000161c:	01e00593          	li	a1,30
    80001620:	f8040513          	addi	a0,s0,-128
    80001624:	00002097          	auipc	ra,0x2
    80001628:	f4c080e7          	jalr	-180(ra) # 80003570 <_Z9getStringPci>
    threadNum = stringToInt(input);
    8000162c:	f8040513          	addi	a0,s0,-128
    80001630:	00002097          	auipc	ra,0x2
    80001634:	014080e7          	jalr	20(ra) # 80003644 <_Z11stringToIntPKc>
    80001638:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    8000163c:	00008517          	auipc	a0,0x8
    80001640:	a8c50513          	addi	a0,a0,-1396 # 800090c8 <_ZTV12ConsumerSync+0x48>
    80001644:	00002097          	auipc	ra,0x2
    80001648:	ea4080e7          	jalr	-348(ra) # 800034e8 <_Z11printStringPKc>
    getString(input, 30);
    8000164c:	01e00593          	li	a1,30
    80001650:	f8040513          	addi	a0,s0,-128
    80001654:	00002097          	auipc	ra,0x2
    80001658:	f1c080e7          	jalr	-228(ra) # 80003570 <_Z9getStringPci>
    n = stringToInt(input);
    8000165c:	f8040513          	addi	a0,s0,-128
    80001660:	00002097          	auipc	ra,0x2
    80001664:	fe4080e7          	jalr	-28(ra) # 80003644 <_Z11stringToIntPKc>
    80001668:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    8000166c:	00008517          	auipc	a0,0x8
    80001670:	a7c50513          	addi	a0,a0,-1412 # 800090e8 <_ZTV12ConsumerSync+0x68>
    80001674:	00002097          	auipc	ra,0x2
    80001678:	e74080e7          	jalr	-396(ra) # 800034e8 <_Z11printStringPKc>
    8000167c:	00000613          	li	a2,0
    80001680:	00a00593          	li	a1,10
    80001684:	00090513          	mv	a0,s2
    80001688:	00002097          	auipc	ra,0x2
    8000168c:	00c080e7          	jalr	12(ra) # 80003694 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80001690:	00008517          	auipc	a0,0x8
    80001694:	a7050513          	addi	a0,a0,-1424 # 80009100 <_ZTV12ConsumerSync+0x80>
    80001698:	00002097          	auipc	ra,0x2
    8000169c:	e50080e7          	jalr	-432(ra) # 800034e8 <_Z11printStringPKc>
    800016a0:	00000613          	li	a2,0
    800016a4:	00a00593          	li	a1,10
    800016a8:	00048513          	mv	a0,s1
    800016ac:	00002097          	auipc	ra,0x2
    800016b0:	fe8080e7          	jalr	-24(ra) # 80003694 <_Z8printIntiii>
    printString(".\n");
    800016b4:	00008517          	auipc	a0,0x8
    800016b8:	a6450513          	addi	a0,a0,-1436 # 80009118 <_ZTV12ConsumerSync+0x98>
    800016bc:	00002097          	auipc	ra,0x2
    800016c0:	e2c080e7          	jalr	-468(ra) # 800034e8 <_Z11printStringPKc>
    if(threadNum > n) {
    800016c4:	0324c463          	blt	s1,s2,800016ec <_Z29producerConsumer_CPP_Sync_APIv+0x118>
    } else if (threadNum < 1) {
    800016c8:	03205c63          	blez	s2,80001700 <_Z29producerConsumer_CPP_Sync_APIv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    800016cc:	03800513          	li	a0,56
    800016d0:	00004097          	auipc	ra,0x4
    800016d4:	218080e7          	jalr	536(ra) # 800058e8 <_Znwm>
    800016d8:	00050a13          	mv	s4,a0
    800016dc:	00048593          	mv	a1,s1
    800016e0:	00002097          	auipc	ra,0x2
    800016e4:	400080e7          	jalr	1024(ra) # 80003ae0 <_ZN9BufferCPPC1Ei>
    800016e8:	0300006f          	j	80001718 <_Z29producerConsumer_CPP_Sync_APIv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800016ec:	00008517          	auipc	a0,0x8
    800016f0:	a3450513          	addi	a0,a0,-1484 # 80009120 <_ZTV12ConsumerSync+0xa0>
    800016f4:	00002097          	auipc	ra,0x2
    800016f8:	df4080e7          	jalr	-524(ra) # 800034e8 <_Z11printStringPKc>
        return;
    800016fc:	0140006f          	j	80001710 <_Z29producerConsumer_CPP_Sync_APIv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80001700:	00008517          	auipc	a0,0x8
    80001704:	a6050513          	addi	a0,a0,-1440 # 80009160 <_ZTV12ConsumerSync+0xe0>
    80001708:	00002097          	auipc	ra,0x2
    8000170c:	de0080e7          	jalr	-544(ra) # 800034e8 <_Z11printStringPKc>
        return;
    80001710:	000b0113          	mv	sp,s6
    80001714:	2440006f          	j	80001958 <_Z29producerConsumer_CPP_Sync_APIv+0x384>
    waitForAll = new Semaphore(0);
    80001718:	01000513          	li	a0,16
    8000171c:	00004097          	auipc	ra,0x4
    80001720:	1cc080e7          	jalr	460(ra) # 800058e8 <_Znwm>
    80001724:	00050493          	mv	s1,a0
    80001728:	00000593          	li	a1,0
    8000172c:	00003097          	auipc	ra,0x3
    80001730:	5a0080e7          	jalr	1440(ra) # 80004ccc <_ZN9SemaphoreC1Ej>
    80001734:	0000a797          	auipc	a5,0xa
    80001738:	e897be23          	sd	s1,-356(a5) # 8000b5d0 <_ZL10waitForAll>
    Thread* threads[threadNum];
    8000173c:	00391793          	slli	a5,s2,0x3
    80001740:	00f78793          	addi	a5,a5,15
    80001744:	ff07f793          	andi	a5,a5,-16
    80001748:	40f10133          	sub	sp,sp,a5
    8000174c:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80001750:	0019079b          	addiw	a5,s2,1
    80001754:	00179713          	slli	a4,a5,0x1
    80001758:	00f70733          	add	a4,a4,a5
    8000175c:	00371793          	slli	a5,a4,0x3
    80001760:	00f78793          	addi	a5,a5,15
    80001764:	ff07f793          	andi	a5,a5,-16
    80001768:	40f10133          	sub	sp,sp,a5
    8000176c:	00010b93          	mv	s7,sp
    data[threadNum].id = threadNum;
    80001770:	00191c13          	slli	s8,s2,0x1
    80001774:	012c0733          	add	a4,s8,s2
    80001778:	00371793          	slli	a5,a4,0x3
    8000177c:	00fb87b3          	add	a5,s7,a5
    80001780:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80001784:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80001788:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    8000178c:	02800513          	li	a0,40
    80001790:	00004097          	auipc	ra,0x4
    80001794:	158080e7          	jalr	344(ra) # 800058e8 <_Znwm>
    80001798:	00050a93          	mv	s5,a0
    8000179c:	012c0c33          	add	s8,s8,s2
    800017a0:	003c1793          	slli	a5,s8,0x3
    800017a4:	00fb84b3          	add	s1,s7,a5
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    800017a8:	00003097          	auipc	ra,0x3
    800017ac:	45c080e7          	jalr	1116(ra) # 80004c04 <_ZN6ThreadC1Ev>
    800017b0:	00008797          	auipc	a5,0x8
    800017b4:	8e078793          	addi	a5,a5,-1824 # 80009090 <_ZTV12ConsumerSync+0x10>
    800017b8:	00fab023          	sd	a5,0(s5)
    800017bc:	029ab023          	sd	s1,32(s5)
    consumerThread->start();
    800017c0:	000a8513          	mv	a0,s5
    800017c4:	00003097          	auipc	ra,0x3
    800017c8:	3d0080e7          	jalr	976(ra) # 80004b94 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800017cc:	00000493          	li	s1,0
    800017d0:	0380006f          	j	80001808 <_Z29producerConsumer_CPP_Sync_APIv+0x234>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    800017d4:	00008797          	auipc	a5,0x8
    800017d8:	89478793          	addi	a5,a5,-1900 # 80009068 <_ZTV12ProducerSync+0x10>
    800017dc:	00fcb023          	sd	a5,0(s9)
    800017e0:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    800017e4:	00349793          	slli	a5,s1,0x3
    800017e8:	00f987b3          	add	a5,s3,a5
    800017ec:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    800017f0:	00349793          	slli	a5,s1,0x3
    800017f4:	00f987b3          	add	a5,s3,a5
    800017f8:	0007b503          	ld	a0,0(a5)
    800017fc:	00003097          	auipc	ra,0x3
    80001800:	398080e7          	jalr	920(ra) # 80004b94 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80001804:	0014849b          	addiw	s1,s1,1
    80001808:	0b24d263          	bge	s1,s2,800018ac <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    8000180c:	00149713          	slli	a4,s1,0x1
    80001810:	00970733          	add	a4,a4,s1
    80001814:	00371793          	slli	a5,a4,0x3
    80001818:	00fb87b3          	add	a5,s7,a5
    8000181c:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80001820:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80001824:	0000a717          	auipc	a4,0xa
    80001828:	dac70713          	addi	a4,a4,-596 # 8000b5d0 <_ZL10waitForAll>
    8000182c:	00073703          	ld	a4,0(a4)
    80001830:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80001834:	02905863          	blez	s1,80001864 <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    80001838:	02800513          	li	a0,40
    8000183c:	00004097          	auipc	ra,0x4
    80001840:	0ac080e7          	jalr	172(ra) # 800058e8 <_Znwm>
    80001844:	00050c93          	mv	s9,a0
    80001848:	00149713          	slli	a4,s1,0x1
    8000184c:	00970733          	add	a4,a4,s1
    80001850:	00371793          	slli	a5,a4,0x3
    80001854:	00fb8c33          	add	s8,s7,a5
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80001858:	00003097          	auipc	ra,0x3
    8000185c:	3ac080e7          	jalr	940(ra) # 80004c04 <_ZN6ThreadC1Ev>
    80001860:	f75ff06f          	j	800017d4 <_Z29producerConsumer_CPP_Sync_APIv+0x200>
            threads[i] = new ProducerKeyboard(data+i);
    80001864:	02800513          	li	a0,40
    80001868:	00004097          	auipc	ra,0x4
    8000186c:	080080e7          	jalr	128(ra) # 800058e8 <_Znwm>
    80001870:	00050c93          	mv	s9,a0
    80001874:	00149713          	slli	a4,s1,0x1
    80001878:	00970733          	add	a4,a4,s1
    8000187c:	00371793          	slli	a5,a4,0x3
    80001880:	00fb8c33          	add	s8,s7,a5
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80001884:	00003097          	auipc	ra,0x3
    80001888:	380080e7          	jalr	896(ra) # 80004c04 <_ZN6ThreadC1Ev>
    8000188c:	00007797          	auipc	a5,0x7
    80001890:	7b478793          	addi	a5,a5,1972 # 80009040 <_ZTV16ProducerKeyboard+0x10>
    80001894:	00fcb023          	sd	a5,0(s9)
    80001898:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    8000189c:	00349793          	slli	a5,s1,0x3
    800018a0:	00f987b3          	add	a5,s3,a5
    800018a4:	0197b023          	sd	s9,0(a5)
    800018a8:	f49ff06f          	j	800017f0 <_Z29producerConsumer_CPP_Sync_APIv+0x21c>
    Thread::dispatch();
    800018ac:	00003097          	auipc	ra,0x3
    800018b0:	330080e7          	jalr	816(ra) # 80004bdc <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    800018b4:	00000493          	li	s1,0
    800018b8:	02994063          	blt	s2,s1,800018d8 <_Z29producerConsumer_CPP_Sync_APIv+0x304>
        waitForAll->wait();
    800018bc:	0000a797          	auipc	a5,0xa
    800018c0:	d1478793          	addi	a5,a5,-748 # 8000b5d0 <_ZL10waitForAll>
    800018c4:	0007b503          	ld	a0,0(a5)
    800018c8:	00003097          	auipc	ra,0x3
    800018cc:	46c080e7          	jalr	1132(ra) # 80004d34 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    800018d0:	0014849b          	addiw	s1,s1,1
    800018d4:	fe5ff06f          	j	800018b8 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    800018d8:	00000493          	li	s1,0
    800018dc:	0080006f          	j	800018e4 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    800018e0:	0014849b          	addiw	s1,s1,1
    800018e4:	0324d263          	bge	s1,s2,80001908 <_Z29producerConsumer_CPP_Sync_APIv+0x334>
        delete threads[i];
    800018e8:	00349793          	slli	a5,s1,0x3
    800018ec:	00f987b3          	add	a5,s3,a5
    800018f0:	0007b503          	ld	a0,0(a5)
    800018f4:	fe0506e3          	beqz	a0,800018e0 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    800018f8:	00053783          	ld	a5,0(a0)
    800018fc:	0087b783          	ld	a5,8(a5)
    80001900:	000780e7          	jalr	a5
    80001904:	fddff06f          	j	800018e0 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    delete consumerThread;
    80001908:	000a8a63          	beqz	s5,8000191c <_Z29producerConsumer_CPP_Sync_APIv+0x348>
    8000190c:	000ab783          	ld	a5,0(s5)
    80001910:	0087b783          	ld	a5,8(a5)
    80001914:	000a8513          	mv	a0,s5
    80001918:	000780e7          	jalr	a5
    delete waitForAll;
    8000191c:	0000a797          	auipc	a5,0xa
    80001920:	cb478793          	addi	a5,a5,-844 # 8000b5d0 <_ZL10waitForAll>
    80001924:	0007b503          	ld	a0,0(a5)
    80001928:	00050863          	beqz	a0,80001938 <_Z29producerConsumer_CPP_Sync_APIv+0x364>
    8000192c:	00053783          	ld	a5,0(a0)
    80001930:	0087b783          	ld	a5,8(a5)
    80001934:	000780e7          	jalr	a5
    delete buffer;
    80001938:	000a0e63          	beqz	s4,80001954 <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    8000193c:	000a0513          	mv	a0,s4
    80001940:	00002097          	auipc	ra,0x2
    80001944:	498080e7          	jalr	1176(ra) # 80003dd8 <_ZN9BufferCPPD1Ev>
    80001948:	000a0513          	mv	a0,s4
    8000194c:	00004097          	auipc	ra,0x4
    80001950:	fec080e7          	jalr	-20(ra) # 80005938 <_ZdlPv>
    80001954:	000b0113          	mv	sp,s6

}
    80001958:	f8040113          	addi	sp,s0,-128
    8000195c:	07813083          	ld	ra,120(sp)
    80001960:	07013403          	ld	s0,112(sp)
    80001964:	06813483          	ld	s1,104(sp)
    80001968:	06013903          	ld	s2,96(sp)
    8000196c:	05813983          	ld	s3,88(sp)
    80001970:	05013a03          	ld	s4,80(sp)
    80001974:	04813a83          	ld	s5,72(sp)
    80001978:	04013b03          	ld	s6,64(sp)
    8000197c:	03813b83          	ld	s7,56(sp)
    80001980:	03013c03          	ld	s8,48(sp)
    80001984:	02813c83          	ld	s9,40(sp)
    80001988:	08010113          	addi	sp,sp,128
    8000198c:	00008067          	ret
    80001990:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80001994:	000a0513          	mv	a0,s4
    80001998:	00004097          	auipc	ra,0x4
    8000199c:	fa0080e7          	jalr	-96(ra) # 80005938 <_ZdlPv>
    800019a0:	00048513          	mv	a0,s1
    800019a4:	0000b097          	auipc	ra,0xb
    800019a8:	dd4080e7          	jalr	-556(ra) # 8000c778 <_Unwind_Resume>
    800019ac:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    800019b0:	00048513          	mv	a0,s1
    800019b4:	00004097          	auipc	ra,0x4
    800019b8:	f84080e7          	jalr	-124(ra) # 80005938 <_ZdlPv>
    800019bc:	00090513          	mv	a0,s2
    800019c0:	0000b097          	auipc	ra,0xb
    800019c4:	db8080e7          	jalr	-584(ra) # 8000c778 <_Unwind_Resume>
    800019c8:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    800019cc:	000a8513          	mv	a0,s5
    800019d0:	00004097          	auipc	ra,0x4
    800019d4:	f68080e7          	jalr	-152(ra) # 80005938 <_ZdlPv>
    800019d8:	00048513          	mv	a0,s1
    800019dc:	0000b097          	auipc	ra,0xb
    800019e0:	d9c080e7          	jalr	-612(ra) # 8000c778 <_Unwind_Resume>
    800019e4:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    800019e8:	000c8513          	mv	a0,s9
    800019ec:	00004097          	auipc	ra,0x4
    800019f0:	f4c080e7          	jalr	-180(ra) # 80005938 <_ZdlPv>
    800019f4:	00048513          	mv	a0,s1
    800019f8:	0000b097          	auipc	ra,0xb
    800019fc:	d80080e7          	jalr	-640(ra) # 8000c778 <_Unwind_Resume>
    80001a00:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80001a04:	000c8513          	mv	a0,s9
    80001a08:	00004097          	auipc	ra,0x4
    80001a0c:	f30080e7          	jalr	-208(ra) # 80005938 <_ZdlPv>
    80001a10:	00048513          	mv	a0,s1
    80001a14:	0000b097          	auipc	ra,0xb
    80001a18:	d64080e7          	jalr	-668(ra) # 8000c778 <_Unwind_Resume>

0000000080001a1c <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80001a1c:	ff010113          	addi	sp,sp,-16
    80001a20:	00113423          	sd	ra,8(sp)
    80001a24:	00813023          	sd	s0,0(sp)
    80001a28:	01010413          	addi	s0,sp,16
    80001a2c:	00007797          	auipc	a5,0x7
    80001a30:	66478793          	addi	a5,a5,1636 # 80009090 <_ZTV12ConsumerSync+0x10>
    80001a34:	00f53023          	sd	a5,0(a0)
    80001a38:	00003097          	auipc	ra,0x3
    80001a3c:	fc8080e7          	jalr	-56(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80001a40:	00813083          	ld	ra,8(sp)
    80001a44:	00013403          	ld	s0,0(sp)
    80001a48:	01010113          	addi	sp,sp,16
    80001a4c:	00008067          	ret

0000000080001a50 <_ZN12ConsumerSyncD0Ev>:
    80001a50:	fe010113          	addi	sp,sp,-32
    80001a54:	00113c23          	sd	ra,24(sp)
    80001a58:	00813823          	sd	s0,16(sp)
    80001a5c:	00913423          	sd	s1,8(sp)
    80001a60:	02010413          	addi	s0,sp,32
    80001a64:	00050493          	mv	s1,a0
    80001a68:	00007797          	auipc	a5,0x7
    80001a6c:	62878793          	addi	a5,a5,1576 # 80009090 <_ZTV12ConsumerSync+0x10>
    80001a70:	00f53023          	sd	a5,0(a0)
    80001a74:	00003097          	auipc	ra,0x3
    80001a78:	f8c080e7          	jalr	-116(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80001a7c:	00048513          	mv	a0,s1
    80001a80:	00004097          	auipc	ra,0x4
    80001a84:	eb8080e7          	jalr	-328(ra) # 80005938 <_ZdlPv>
    80001a88:	01813083          	ld	ra,24(sp)
    80001a8c:	01013403          	ld	s0,16(sp)
    80001a90:	00813483          	ld	s1,8(sp)
    80001a94:	02010113          	addi	sp,sp,32
    80001a98:	00008067          	ret

0000000080001a9c <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80001a9c:	ff010113          	addi	sp,sp,-16
    80001aa0:	00113423          	sd	ra,8(sp)
    80001aa4:	00813023          	sd	s0,0(sp)
    80001aa8:	01010413          	addi	s0,sp,16
    80001aac:	00007797          	auipc	a5,0x7
    80001ab0:	5bc78793          	addi	a5,a5,1468 # 80009068 <_ZTV12ProducerSync+0x10>
    80001ab4:	00f53023          	sd	a5,0(a0)
    80001ab8:	00003097          	auipc	ra,0x3
    80001abc:	f48080e7          	jalr	-184(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80001ac0:	00813083          	ld	ra,8(sp)
    80001ac4:	00013403          	ld	s0,0(sp)
    80001ac8:	01010113          	addi	sp,sp,16
    80001acc:	00008067          	ret

0000000080001ad0 <_ZN12ProducerSyncD0Ev>:
    80001ad0:	fe010113          	addi	sp,sp,-32
    80001ad4:	00113c23          	sd	ra,24(sp)
    80001ad8:	00813823          	sd	s0,16(sp)
    80001adc:	00913423          	sd	s1,8(sp)
    80001ae0:	02010413          	addi	s0,sp,32
    80001ae4:	00050493          	mv	s1,a0
    80001ae8:	00007797          	auipc	a5,0x7
    80001aec:	58078793          	addi	a5,a5,1408 # 80009068 <_ZTV12ProducerSync+0x10>
    80001af0:	00f53023          	sd	a5,0(a0)
    80001af4:	00003097          	auipc	ra,0x3
    80001af8:	f0c080e7          	jalr	-244(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80001afc:	00048513          	mv	a0,s1
    80001b00:	00004097          	auipc	ra,0x4
    80001b04:	e38080e7          	jalr	-456(ra) # 80005938 <_ZdlPv>
    80001b08:	01813083          	ld	ra,24(sp)
    80001b0c:	01013403          	ld	s0,16(sp)
    80001b10:	00813483          	ld	s1,8(sp)
    80001b14:	02010113          	addi	sp,sp,32
    80001b18:	00008067          	ret

0000000080001b1c <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80001b1c:	ff010113          	addi	sp,sp,-16
    80001b20:	00113423          	sd	ra,8(sp)
    80001b24:	00813023          	sd	s0,0(sp)
    80001b28:	01010413          	addi	s0,sp,16
    80001b2c:	00007797          	auipc	a5,0x7
    80001b30:	51478793          	addi	a5,a5,1300 # 80009040 <_ZTV16ProducerKeyboard+0x10>
    80001b34:	00f53023          	sd	a5,0(a0)
    80001b38:	00003097          	auipc	ra,0x3
    80001b3c:	ec8080e7          	jalr	-312(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80001b40:	00813083          	ld	ra,8(sp)
    80001b44:	00013403          	ld	s0,0(sp)
    80001b48:	01010113          	addi	sp,sp,16
    80001b4c:	00008067          	ret

0000000080001b50 <_ZN16ProducerKeyboardD0Ev>:
    80001b50:	fe010113          	addi	sp,sp,-32
    80001b54:	00113c23          	sd	ra,24(sp)
    80001b58:	00813823          	sd	s0,16(sp)
    80001b5c:	00913423          	sd	s1,8(sp)
    80001b60:	02010413          	addi	s0,sp,32
    80001b64:	00050493          	mv	s1,a0
    80001b68:	00007797          	auipc	a5,0x7
    80001b6c:	4d878793          	addi	a5,a5,1240 # 80009040 <_ZTV16ProducerKeyboard+0x10>
    80001b70:	00f53023          	sd	a5,0(a0)
    80001b74:	00003097          	auipc	ra,0x3
    80001b78:	e8c080e7          	jalr	-372(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80001b7c:	00048513          	mv	a0,s1
    80001b80:	00004097          	auipc	ra,0x4
    80001b84:	db8080e7          	jalr	-584(ra) # 80005938 <_ZdlPv>
    80001b88:	01813083          	ld	ra,24(sp)
    80001b8c:	01013403          	ld	s0,16(sp)
    80001b90:	00813483          	ld	s1,8(sp)
    80001b94:	02010113          	addi	sp,sp,32
    80001b98:	00008067          	ret

0000000080001b9c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80001b9c:	ff010113          	addi	sp,sp,-16
    80001ba0:	00113423          	sd	ra,8(sp)
    80001ba4:	00813023          	sd	s0,0(sp)
    80001ba8:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80001bac:	02053583          	ld	a1,32(a0)
    80001bb0:	fffff097          	auipc	ra,0xfffff
    80001bb4:	7c8080e7          	jalr	1992(ra) # 80001378 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80001bb8:	00813083          	ld	ra,8(sp)
    80001bbc:	00013403          	ld	s0,0(sp)
    80001bc0:	01010113          	addi	sp,sp,16
    80001bc4:	00008067          	ret

0000000080001bc8 <_ZN12ProducerSync3runEv>:
    void run() override {
    80001bc8:	ff010113          	addi	sp,sp,-16
    80001bcc:	00113423          	sd	ra,8(sp)
    80001bd0:	00813023          	sd	s0,0(sp)
    80001bd4:	01010413          	addi	s0,sp,16
        producer(td);
    80001bd8:	02053583          	ld	a1,32(a0)
    80001bdc:	00000097          	auipc	ra,0x0
    80001be0:	85c080e7          	jalr	-1956(ra) # 80001438 <_ZN12ProducerSync8producerEPv>
    }
    80001be4:	00813083          	ld	ra,8(sp)
    80001be8:	00013403          	ld	s0,0(sp)
    80001bec:	01010113          	addi	sp,sp,16
    80001bf0:	00008067          	ret

0000000080001bf4 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80001bf4:	ff010113          	addi	sp,sp,-16
    80001bf8:	00113423          	sd	ra,8(sp)
    80001bfc:	00813023          	sd	s0,0(sp)
    80001c00:	01010413          	addi	s0,sp,16
        consumer(td);
    80001c04:	02053583          	ld	a1,32(a0)
    80001c08:	00000097          	auipc	ra,0x0
    80001c0c:	8cc080e7          	jalr	-1844(ra) # 800014d4 <_ZN12ConsumerSync8consumerEPv>
    }
    80001c10:	00813083          	ld	ra,8(sp)
    80001c14:	00013403          	ld	s0,0(sp)
    80001c18:	01010113          	addi	sp,sp,16
    80001c1c:	00008067          	ret

0000000080001c20 <_ZL9fibonaccim>:
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    if (n == 0 || n == 1) { return n; }
    80001c20:	00100793          	li	a5,1
    80001c24:	06a7f863          	bgeu	a5,a0,80001c94 <_ZL9fibonaccim+0x74>
static uint64 fibonacci(uint64 n) {
    80001c28:	fe010113          	addi	sp,sp,-32
    80001c2c:	00113c23          	sd	ra,24(sp)
    80001c30:	00813823          	sd	s0,16(sp)
    80001c34:	00913423          	sd	s1,8(sp)
    80001c38:	01213023          	sd	s2,0(sp)
    80001c3c:	02010413          	addi	s0,sp,32
    80001c40:	00050493          	mv	s1,a0
    if (n % 10 == 0) { thread_dispatch(); }
    80001c44:	00a00793          	li	a5,10
    80001c48:	02f577b3          	remu	a5,a0,a5
    80001c4c:	02078e63          	beqz	a5,80001c88 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001c50:	fff48513          	addi	a0,s1,-1
    80001c54:	00000097          	auipc	ra,0x0
    80001c58:	fcc080e7          	jalr	-52(ra) # 80001c20 <_ZL9fibonaccim>
    80001c5c:	00050913          	mv	s2,a0
    80001c60:	ffe48513          	addi	a0,s1,-2
    80001c64:	00000097          	auipc	ra,0x0
    80001c68:	fbc080e7          	jalr	-68(ra) # 80001c20 <_ZL9fibonaccim>
    80001c6c:	00a90533          	add	a0,s2,a0
}
    80001c70:	01813083          	ld	ra,24(sp)
    80001c74:	01013403          	ld	s0,16(sp)
    80001c78:	00813483          	ld	s1,8(sp)
    80001c7c:	00013903          	ld	s2,0(sp)
    80001c80:	02010113          	addi	sp,sp,32
    80001c84:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80001c88:	00004097          	auipc	ra,0x4
    80001c8c:	100080e7          	jalr	256(ra) # 80005d88 <_Z15thread_dispatchv>
    80001c90:	fc1ff06f          	j	80001c50 <_ZL9fibonaccim+0x30>
}
    80001c94:	00008067          	ret

0000000080001c98 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80001c98:	fe010113          	addi	sp,sp,-32
    80001c9c:	00113c23          	sd	ra,24(sp)
    80001ca0:	00813823          	sd	s0,16(sp)
    80001ca4:	00913423          	sd	s1,8(sp)
    80001ca8:	01213023          	sd	s2,0(sp)
    80001cac:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001cb0:	00a00493          	li	s1,10
    for (; i < 13; i++) {
    80001cb4:	00c00793          	li	a5,12
    80001cb8:	0497e263          	bltu	a5,s1,80001cfc <_ZL11workerBodyDPv+0x64>
        printString("D: i="); printInt(i); printString("\n");
    80001cbc:	00007517          	auipc	a0,0x7
    80001cc0:	4d450513          	addi	a0,a0,1236 # 80009190 <_ZTV12ConsumerSync+0x110>
    80001cc4:	00002097          	auipc	ra,0x2
    80001cc8:	824080e7          	jalr	-2012(ra) # 800034e8 <_Z11printStringPKc>
    80001ccc:	00000613          	li	a2,0
    80001cd0:	00a00593          	li	a1,10
    80001cd4:	00048513          	mv	a0,s1
    80001cd8:	00002097          	auipc	ra,0x2
    80001cdc:	9bc080e7          	jalr	-1604(ra) # 80003694 <_Z8printIntiii>
    80001ce0:	00007517          	auipc	a0,0x7
    80001ce4:	79850513          	addi	a0,a0,1944 # 80009478 <_ZTV8Consumer+0x1a0>
    80001ce8:	00002097          	auipc	ra,0x2
    80001cec:	800080e7          	jalr	-2048(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80001cf0:	0014849b          	addiw	s1,s1,1
    80001cf4:	0ff4f493          	andi	s1,s1,255
    80001cf8:	fbdff06f          	j	80001cb4 <_ZL11workerBodyDPv+0x1c>
    }

    printString("D: dispatch\n");
    80001cfc:	00007517          	auipc	a0,0x7
    80001d00:	49c50513          	addi	a0,a0,1180 # 80009198 <_ZTV12ConsumerSync+0x118>
    80001d04:	00001097          	auipc	ra,0x1
    80001d08:	7e4080e7          	jalr	2020(ra) # 800034e8 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80001d0c:	00500313          	li	t1,5
    thread_dispatch();
    80001d10:	00004097          	auipc	ra,0x4
    80001d14:	078080e7          	jalr	120(ra) # 80005d88 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80001d18:	01000513          	li	a0,16
    80001d1c:	00000097          	auipc	ra,0x0
    80001d20:	f04080e7          	jalr	-252(ra) # 80001c20 <_ZL9fibonaccim>
    80001d24:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80001d28:	00007517          	auipc	a0,0x7
    80001d2c:	48050513          	addi	a0,a0,1152 # 800091a8 <_ZTV12ConsumerSync+0x128>
    80001d30:	00001097          	auipc	ra,0x1
    80001d34:	7b8080e7          	jalr	1976(ra) # 800034e8 <_Z11printStringPKc>
    80001d38:	00000613          	li	a2,0
    80001d3c:	00a00593          	li	a1,10
    80001d40:	0009051b          	sext.w	a0,s2
    80001d44:	00002097          	auipc	ra,0x2
    80001d48:	950080e7          	jalr	-1712(ra) # 80003694 <_Z8printIntiii>
    80001d4c:	00007517          	auipc	a0,0x7
    80001d50:	72c50513          	addi	a0,a0,1836 # 80009478 <_ZTV8Consumer+0x1a0>
    80001d54:	00001097          	auipc	ra,0x1
    80001d58:	794080e7          	jalr	1940(ra) # 800034e8 <_Z11printStringPKc>

    for (; i < 16; i++) {
    80001d5c:	00f00793          	li	a5,15
    80001d60:	0497e263          	bltu	a5,s1,80001da4 <_ZL11workerBodyDPv+0x10c>
        printString("D: i="); printInt(i); printString("\n");
    80001d64:	00007517          	auipc	a0,0x7
    80001d68:	42c50513          	addi	a0,a0,1068 # 80009190 <_ZTV12ConsumerSync+0x110>
    80001d6c:	00001097          	auipc	ra,0x1
    80001d70:	77c080e7          	jalr	1916(ra) # 800034e8 <_Z11printStringPKc>
    80001d74:	00000613          	li	a2,0
    80001d78:	00a00593          	li	a1,10
    80001d7c:	00048513          	mv	a0,s1
    80001d80:	00002097          	auipc	ra,0x2
    80001d84:	914080e7          	jalr	-1772(ra) # 80003694 <_Z8printIntiii>
    80001d88:	00007517          	auipc	a0,0x7
    80001d8c:	6f050513          	addi	a0,a0,1776 # 80009478 <_ZTV8Consumer+0x1a0>
    80001d90:	00001097          	auipc	ra,0x1
    80001d94:	758080e7          	jalr	1880(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80001d98:	0014849b          	addiw	s1,s1,1
    80001d9c:	0ff4f493          	andi	s1,s1,255
    80001da0:	fbdff06f          	j	80001d5c <_ZL11workerBodyDPv+0xc4>
    }

    printString("D finished!\n");
    80001da4:	00007517          	auipc	a0,0x7
    80001da8:	41450513          	addi	a0,a0,1044 # 800091b8 <_ZTV12ConsumerSync+0x138>
    80001dac:	00001097          	auipc	ra,0x1
    80001db0:	73c080e7          	jalr	1852(ra) # 800034e8 <_Z11printStringPKc>
    finishedD = true;
    80001db4:	00100793          	li	a5,1
    80001db8:	0000a717          	auipc	a4,0xa
    80001dbc:	82f70023          	sb	a5,-2016(a4) # 8000b5d8 <_ZL9finishedD>
    thread_dispatch();
    80001dc0:	00004097          	auipc	ra,0x4
    80001dc4:	fc8080e7          	jalr	-56(ra) # 80005d88 <_Z15thread_dispatchv>
}
    80001dc8:	01813083          	ld	ra,24(sp)
    80001dcc:	01013403          	ld	s0,16(sp)
    80001dd0:	00813483          	ld	s1,8(sp)
    80001dd4:	00013903          	ld	s2,0(sp)
    80001dd8:	02010113          	addi	sp,sp,32
    80001ddc:	00008067          	ret

0000000080001de0 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80001de0:	fe010113          	addi	sp,sp,-32
    80001de4:	00113c23          	sd	ra,24(sp)
    80001de8:	00813823          	sd	s0,16(sp)
    80001dec:	00913423          	sd	s1,8(sp)
    80001df0:	01213023          	sd	s2,0(sp)
    80001df4:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001df8:	00000493          	li	s1,0
    for (; i < 3; i++) {
    80001dfc:	00200793          	li	a5,2
    80001e00:	0497e263          	bltu	a5,s1,80001e44 <_ZL11workerBodyCPv+0x64>
        printString("C: i="); printInt(i); printString("\n");
    80001e04:	00007517          	auipc	a0,0x7
    80001e08:	3c450513          	addi	a0,a0,964 # 800091c8 <_ZTV12ConsumerSync+0x148>
    80001e0c:	00001097          	auipc	ra,0x1
    80001e10:	6dc080e7          	jalr	1756(ra) # 800034e8 <_Z11printStringPKc>
    80001e14:	00000613          	li	a2,0
    80001e18:	00a00593          	li	a1,10
    80001e1c:	00048513          	mv	a0,s1
    80001e20:	00002097          	auipc	ra,0x2
    80001e24:	874080e7          	jalr	-1932(ra) # 80003694 <_Z8printIntiii>
    80001e28:	00007517          	auipc	a0,0x7
    80001e2c:	65050513          	addi	a0,a0,1616 # 80009478 <_ZTV8Consumer+0x1a0>
    80001e30:	00001097          	auipc	ra,0x1
    80001e34:	6b8080e7          	jalr	1720(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80001e38:	0014849b          	addiw	s1,s1,1
    80001e3c:	0ff4f493          	andi	s1,s1,255
    80001e40:	fbdff06f          	j	80001dfc <_ZL11workerBodyCPv+0x1c>
    printString("C: dispatch\n");
    80001e44:	00007517          	auipc	a0,0x7
    80001e48:	38c50513          	addi	a0,a0,908 # 800091d0 <_ZTV12ConsumerSync+0x150>
    80001e4c:	00001097          	auipc	ra,0x1
    80001e50:	69c080e7          	jalr	1692(ra) # 800034e8 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001e54:	00700313          	li	t1,7
    thread_dispatch();
    80001e58:	00004097          	auipc	ra,0x4
    80001e5c:	f30080e7          	jalr	-208(ra) # 80005d88 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001e60:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80001e64:	00007517          	auipc	a0,0x7
    80001e68:	37c50513          	addi	a0,a0,892 # 800091e0 <_ZTV12ConsumerSync+0x160>
    80001e6c:	00001097          	auipc	ra,0x1
    80001e70:	67c080e7          	jalr	1660(ra) # 800034e8 <_Z11printStringPKc>
    80001e74:	00000613          	li	a2,0
    80001e78:	00a00593          	li	a1,10
    80001e7c:	0009051b          	sext.w	a0,s2
    80001e80:	00002097          	auipc	ra,0x2
    80001e84:	814080e7          	jalr	-2028(ra) # 80003694 <_Z8printIntiii>
    80001e88:	00007517          	auipc	a0,0x7
    80001e8c:	5f050513          	addi	a0,a0,1520 # 80009478 <_ZTV8Consumer+0x1a0>
    80001e90:	00001097          	auipc	ra,0x1
    80001e94:	658080e7          	jalr	1624(ra) # 800034e8 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80001e98:	00c00513          	li	a0,12
    80001e9c:	00000097          	auipc	ra,0x0
    80001ea0:	d84080e7          	jalr	-636(ra) # 80001c20 <_ZL9fibonaccim>
    80001ea4:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80001ea8:	00007517          	auipc	a0,0x7
    80001eac:	34050513          	addi	a0,a0,832 # 800091e8 <_ZTV12ConsumerSync+0x168>
    80001eb0:	00001097          	auipc	ra,0x1
    80001eb4:	638080e7          	jalr	1592(ra) # 800034e8 <_Z11printStringPKc>
    80001eb8:	00000613          	li	a2,0
    80001ebc:	00a00593          	li	a1,10
    80001ec0:	0009051b          	sext.w	a0,s2
    80001ec4:	00001097          	auipc	ra,0x1
    80001ec8:	7d0080e7          	jalr	2000(ra) # 80003694 <_Z8printIntiii>
    80001ecc:	00007517          	auipc	a0,0x7
    80001ed0:	5ac50513          	addi	a0,a0,1452 # 80009478 <_ZTV8Consumer+0x1a0>
    80001ed4:	00001097          	auipc	ra,0x1
    80001ed8:	614080e7          	jalr	1556(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80001edc:	00500793          	li	a5,5
    80001ee0:	0497e263          	bltu	a5,s1,80001f24 <_ZL11workerBodyCPv+0x144>
        printString("C: i="); printInt(i); printString("\n");
    80001ee4:	00007517          	auipc	a0,0x7
    80001ee8:	2e450513          	addi	a0,a0,740 # 800091c8 <_ZTV12ConsumerSync+0x148>
    80001eec:	00001097          	auipc	ra,0x1
    80001ef0:	5fc080e7          	jalr	1532(ra) # 800034e8 <_Z11printStringPKc>
    80001ef4:	00000613          	li	a2,0
    80001ef8:	00a00593          	li	a1,10
    80001efc:	00048513          	mv	a0,s1
    80001f00:	00001097          	auipc	ra,0x1
    80001f04:	794080e7          	jalr	1940(ra) # 80003694 <_Z8printIntiii>
    80001f08:	00007517          	auipc	a0,0x7
    80001f0c:	57050513          	addi	a0,a0,1392 # 80009478 <_ZTV8Consumer+0x1a0>
    80001f10:	00001097          	auipc	ra,0x1
    80001f14:	5d8080e7          	jalr	1496(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80001f18:	0014849b          	addiw	s1,s1,1
    80001f1c:	0ff4f493          	andi	s1,s1,255
    80001f20:	fbdff06f          	j	80001edc <_ZL11workerBodyCPv+0xfc>
    printString("A finished!\n");
    80001f24:	00007517          	auipc	a0,0x7
    80001f28:	2d450513          	addi	a0,a0,724 # 800091f8 <_ZTV12ConsumerSync+0x178>
    80001f2c:	00001097          	auipc	ra,0x1
    80001f30:	5bc080e7          	jalr	1468(ra) # 800034e8 <_Z11printStringPKc>
    finishedC = true;
    80001f34:	00100793          	li	a5,1
    80001f38:	00009717          	auipc	a4,0x9
    80001f3c:	6af700a3          	sb	a5,1697(a4) # 8000b5d9 <_ZL9finishedC>
    thread_dispatch();
    80001f40:	00004097          	auipc	ra,0x4
    80001f44:	e48080e7          	jalr	-440(ra) # 80005d88 <_Z15thread_dispatchv>
}
    80001f48:	01813083          	ld	ra,24(sp)
    80001f4c:	01013403          	ld	s0,16(sp)
    80001f50:	00813483          	ld	s1,8(sp)
    80001f54:	00013903          	ld	s2,0(sp)
    80001f58:	02010113          	addi	sp,sp,32
    80001f5c:	00008067          	ret

0000000080001f60 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80001f60:	fe010113          	addi	sp,sp,-32
    80001f64:	00113c23          	sd	ra,24(sp)
    80001f68:	00813823          	sd	s0,16(sp)
    80001f6c:	00913423          	sd	s1,8(sp)
    80001f70:	01213023          	sd	s2,0(sp)
    80001f74:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80001f78:	00000913          	li	s2,0
    80001f7c:	0400006f          	j	80001fbc <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    80001f80:	00004097          	auipc	ra,0x4
    80001f84:	e08080e7          	jalr	-504(ra) # 80005d88 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001f88:	00148493          	addi	s1,s1,1
    80001f8c:	000027b7          	lui	a5,0x2
    80001f90:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001f94:	0097ee63          	bltu	a5,s1,80001fb0 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001f98:	00000713          	li	a4,0
    80001f9c:	000077b7          	lui	a5,0x7
    80001fa0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001fa4:	fce7eee3          	bltu	a5,a4,80001f80 <_ZL11workerBodyBPv+0x20>
    80001fa8:	00170713          	addi	a4,a4,1
    80001fac:	ff1ff06f          	j	80001f9c <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80001fb0:	00a00793          	li	a5,10
    80001fb4:	04f90663          	beq	s2,a5,80002000 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    80001fb8:	00190913          	addi	s2,s2,1
    80001fbc:	00f00793          	li	a5,15
    80001fc0:	0527e463          	bltu	a5,s2,80002008 <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    80001fc4:	00007517          	auipc	a0,0x7
    80001fc8:	24450513          	addi	a0,a0,580 # 80009208 <_ZTV12ConsumerSync+0x188>
    80001fcc:	00001097          	auipc	ra,0x1
    80001fd0:	51c080e7          	jalr	1308(ra) # 800034e8 <_Z11printStringPKc>
    80001fd4:	00000613          	li	a2,0
    80001fd8:	00a00593          	li	a1,10
    80001fdc:	0009051b          	sext.w	a0,s2
    80001fe0:	00001097          	auipc	ra,0x1
    80001fe4:	6b4080e7          	jalr	1716(ra) # 80003694 <_Z8printIntiii>
    80001fe8:	00007517          	auipc	a0,0x7
    80001fec:	49050513          	addi	a0,a0,1168 # 80009478 <_ZTV8Consumer+0x1a0>
    80001ff0:	00001097          	auipc	ra,0x1
    80001ff4:	4f8080e7          	jalr	1272(ra) # 800034e8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001ff8:	00000493          	li	s1,0
    80001ffc:	f91ff06f          	j	80001f8c <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80002000:	14102ff3          	csrr	t6,sepc
    80002004:	fb5ff06f          	j	80001fb8 <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80002008:	00007517          	auipc	a0,0x7
    8000200c:	20850513          	addi	a0,a0,520 # 80009210 <_ZTV12ConsumerSync+0x190>
    80002010:	00001097          	auipc	ra,0x1
    80002014:	4d8080e7          	jalr	1240(ra) # 800034e8 <_Z11printStringPKc>
    finishedB = true;
    80002018:	00100793          	li	a5,1
    8000201c:	00009717          	auipc	a4,0x9
    80002020:	5af70f23          	sb	a5,1470(a4) # 8000b5da <_ZL9finishedB>
    thread_dispatch();
    80002024:	00004097          	auipc	ra,0x4
    80002028:	d64080e7          	jalr	-668(ra) # 80005d88 <_Z15thread_dispatchv>
}
    8000202c:	01813083          	ld	ra,24(sp)
    80002030:	01013403          	ld	s0,16(sp)
    80002034:	00813483          	ld	s1,8(sp)
    80002038:	00013903          	ld	s2,0(sp)
    8000203c:	02010113          	addi	sp,sp,32
    80002040:	00008067          	ret

0000000080002044 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80002044:	fe010113          	addi	sp,sp,-32
    80002048:	00113c23          	sd	ra,24(sp)
    8000204c:	00813823          	sd	s0,16(sp)
    80002050:	00913423          	sd	s1,8(sp)
    80002054:	01213023          	sd	s2,0(sp)
    80002058:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000205c:	00000913          	li	s2,0
    80002060:	0380006f          	j	80002098 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80002064:	00004097          	auipc	ra,0x4
    80002068:	d24080e7          	jalr	-732(ra) # 80005d88 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000206c:	00148493          	addi	s1,s1,1
    80002070:	000027b7          	lui	a5,0x2
    80002074:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002078:	0097ee63          	bltu	a5,s1,80002094 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000207c:	00000713          	li	a4,0
    80002080:	000077b7          	lui	a5,0x7
    80002084:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002088:	fce7eee3          	bltu	a5,a4,80002064 <_ZL11workerBodyAPv+0x20>
    8000208c:	00170713          	addi	a4,a4,1
    80002090:	ff1ff06f          	j	80002080 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80002094:	00190913          	addi	s2,s2,1
    80002098:	00900793          	li	a5,9
    8000209c:	0527e063          	bltu	a5,s2,800020dc <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800020a0:	00007517          	auipc	a0,0x7
    800020a4:	18050513          	addi	a0,a0,384 # 80009220 <_ZTV12ConsumerSync+0x1a0>
    800020a8:	00001097          	auipc	ra,0x1
    800020ac:	440080e7          	jalr	1088(ra) # 800034e8 <_Z11printStringPKc>
    800020b0:	00000613          	li	a2,0
    800020b4:	00a00593          	li	a1,10
    800020b8:	0009051b          	sext.w	a0,s2
    800020bc:	00001097          	auipc	ra,0x1
    800020c0:	5d8080e7          	jalr	1496(ra) # 80003694 <_Z8printIntiii>
    800020c4:	00007517          	auipc	a0,0x7
    800020c8:	3b450513          	addi	a0,a0,948 # 80009478 <_ZTV8Consumer+0x1a0>
    800020cc:	00001097          	auipc	ra,0x1
    800020d0:	41c080e7          	jalr	1052(ra) # 800034e8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800020d4:	00000493          	li	s1,0
    800020d8:	f99ff06f          	j	80002070 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800020dc:	00007517          	auipc	a0,0x7
    800020e0:	11c50513          	addi	a0,a0,284 # 800091f8 <_ZTV12ConsumerSync+0x178>
    800020e4:	00001097          	auipc	ra,0x1
    800020e8:	404080e7          	jalr	1028(ra) # 800034e8 <_Z11printStringPKc>
    finishedA = true;
    800020ec:	00100793          	li	a5,1
    800020f0:	00009717          	auipc	a4,0x9
    800020f4:	4ef705a3          	sb	a5,1259(a4) # 8000b5db <_ZL9finishedA>
}
    800020f8:	01813083          	ld	ra,24(sp)
    800020fc:	01013403          	ld	s0,16(sp)
    80002100:	00813483          	ld	s1,8(sp)
    80002104:	00013903          	ld	s2,0(sp)
    80002108:	02010113          	addi	sp,sp,32
    8000210c:	00008067          	ret

0000000080002110 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80002110:	fd010113          	addi	sp,sp,-48
    80002114:	02113423          	sd	ra,40(sp)
    80002118:	02813023          	sd	s0,32(sp)
    8000211c:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80002120:	00000613          	li	a2,0
    80002124:	00000597          	auipc	a1,0x0
    80002128:	f2058593          	addi	a1,a1,-224 # 80002044 <_ZL11workerBodyAPv>
    8000212c:	fd040513          	addi	a0,s0,-48
    80002130:	00004097          	auipc	ra,0x4
    80002134:	ba8080e7          	jalr	-1112(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80002138:	00007517          	auipc	a0,0x7
    8000213c:	0f050513          	addi	a0,a0,240 # 80009228 <_ZTV12ConsumerSync+0x1a8>
    80002140:	00001097          	auipc	ra,0x1
    80002144:	3a8080e7          	jalr	936(ra) # 800034e8 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80002148:	00000613          	li	a2,0
    8000214c:	00000597          	auipc	a1,0x0
    80002150:	e1458593          	addi	a1,a1,-492 # 80001f60 <_ZL11workerBodyBPv>
    80002154:	fd840513          	addi	a0,s0,-40
    80002158:	00004097          	auipc	ra,0x4
    8000215c:	b80080e7          	jalr	-1152(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    80002160:	00007517          	auipc	a0,0x7
    80002164:	0e050513          	addi	a0,a0,224 # 80009240 <_ZTV12ConsumerSync+0x1c0>
    80002168:	00001097          	auipc	ra,0x1
    8000216c:	380080e7          	jalr	896(ra) # 800034e8 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80002170:	00000613          	li	a2,0
    80002174:	00000597          	auipc	a1,0x0
    80002178:	c6c58593          	addi	a1,a1,-916 # 80001de0 <_ZL11workerBodyCPv>
    8000217c:	fe040513          	addi	a0,s0,-32
    80002180:	00004097          	auipc	ra,0x4
    80002184:	b58080e7          	jalr	-1192(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80002188:	00007517          	auipc	a0,0x7
    8000218c:	0d050513          	addi	a0,a0,208 # 80009258 <_ZTV12ConsumerSync+0x1d8>
    80002190:	00001097          	auipc	ra,0x1
    80002194:	358080e7          	jalr	856(ra) # 800034e8 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80002198:	00000613          	li	a2,0
    8000219c:	00000597          	auipc	a1,0x0
    800021a0:	afc58593          	addi	a1,a1,-1284 # 80001c98 <_ZL11workerBodyDPv>
    800021a4:	fe840513          	addi	a0,s0,-24
    800021a8:	00004097          	auipc	ra,0x4
    800021ac:	b30080e7          	jalr	-1232(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    800021b0:	00007517          	auipc	a0,0x7
    800021b4:	0c050513          	addi	a0,a0,192 # 80009270 <_ZTV12ConsumerSync+0x1f0>
    800021b8:	00001097          	auipc	ra,0x1
    800021bc:	330080e7          	jalr	816(ra) # 800034e8 <_Z11printStringPKc>
    800021c0:	00c0006f          	j	800021cc <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800021c4:	00004097          	auipc	ra,0x4
    800021c8:	bc4080e7          	jalr	-1084(ra) # 80005d88 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800021cc:	00009797          	auipc	a5,0x9
    800021d0:	40f78793          	addi	a5,a5,1039 # 8000b5db <_ZL9finishedA>
    800021d4:	0007c783          	lbu	a5,0(a5)
    800021d8:	0ff7f793          	andi	a5,a5,255
    800021dc:	fe0784e3          	beqz	a5,800021c4 <_Z16System_Mode_testv+0xb4>
    800021e0:	00009797          	auipc	a5,0x9
    800021e4:	3fa78793          	addi	a5,a5,1018 # 8000b5da <_ZL9finishedB>
    800021e8:	0007c783          	lbu	a5,0(a5)
    800021ec:	0ff7f793          	andi	a5,a5,255
    800021f0:	fc078ae3          	beqz	a5,800021c4 <_Z16System_Mode_testv+0xb4>
    800021f4:	00009797          	auipc	a5,0x9
    800021f8:	3e578793          	addi	a5,a5,997 # 8000b5d9 <_ZL9finishedC>
    800021fc:	0007c783          	lbu	a5,0(a5)
    80002200:	0ff7f793          	andi	a5,a5,255
    80002204:	fc0780e3          	beqz	a5,800021c4 <_Z16System_Mode_testv+0xb4>
    80002208:	00009797          	auipc	a5,0x9
    8000220c:	3d078793          	addi	a5,a5,976 # 8000b5d8 <_ZL9finishedD>
    80002210:	0007c783          	lbu	a5,0(a5)
    80002214:	0ff7f793          	andi	a5,a5,255
    80002218:	fa0786e3          	beqz	a5,800021c4 <_Z16System_Mode_testv+0xb4>
    }

}
    8000221c:	02813083          	ld	ra,40(sp)
    80002220:	02013403          	ld	s0,32(sp)
    80002224:	03010113          	addi	sp,sp,48
    80002228:	00008067          	ret

000000008000222c <_ZL9fibonaccim>:
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    if (n == 0 || n == 1) { return n; }
    8000222c:	00100793          	li	a5,1
    80002230:	06a7f863          	bgeu	a5,a0,800022a0 <_ZL9fibonaccim+0x74>
static uint64 fibonacci(uint64 n) {
    80002234:	fe010113          	addi	sp,sp,-32
    80002238:	00113c23          	sd	ra,24(sp)
    8000223c:	00813823          	sd	s0,16(sp)
    80002240:	00913423          	sd	s1,8(sp)
    80002244:	01213023          	sd	s2,0(sp)
    80002248:	02010413          	addi	s0,sp,32
    8000224c:	00050493          	mv	s1,a0
    if (n % 10 == 0) { thread_dispatch(); }
    80002250:	00a00793          	li	a5,10
    80002254:	02f577b3          	remu	a5,a0,a5
    80002258:	02078e63          	beqz	a5,80002294 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    8000225c:	fff48513          	addi	a0,s1,-1
    80002260:	00000097          	auipc	ra,0x0
    80002264:	fcc080e7          	jalr	-52(ra) # 8000222c <_ZL9fibonaccim>
    80002268:	00050913          	mv	s2,a0
    8000226c:	ffe48513          	addi	a0,s1,-2
    80002270:	00000097          	auipc	ra,0x0
    80002274:	fbc080e7          	jalr	-68(ra) # 8000222c <_ZL9fibonaccim>
    80002278:	00a90533          	add	a0,s2,a0
}
    8000227c:	01813083          	ld	ra,24(sp)
    80002280:	01013403          	ld	s0,16(sp)
    80002284:	00813483          	ld	s1,8(sp)
    80002288:	00013903          	ld	s2,0(sp)
    8000228c:	02010113          	addi	sp,sp,32
    80002290:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80002294:	00004097          	auipc	ra,0x4
    80002298:	af4080e7          	jalr	-1292(ra) # 80005d88 <_Z15thread_dispatchv>
    8000229c:	fc1ff06f          	j	8000225c <_ZL9fibonaccim+0x30>
}
    800022a0:	00008067          	ret

00000000800022a4 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    800022a4:	fe010113          	addi	sp,sp,-32
    800022a8:	00113c23          	sd	ra,24(sp)
    800022ac:	00813823          	sd	s0,16(sp)
    800022b0:	00913423          	sd	s1,8(sp)
    800022b4:	01213023          	sd	s2,0(sp)
    800022b8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800022bc:	00a00493          	li	s1,10
    for (; i < 13; i++) {
    800022c0:	00c00793          	li	a5,12
    800022c4:	0497e263          	bltu	a5,s1,80002308 <_ZL11workerBodyDPv+0x64>
        printString("D: i="); printInt(i); printString("\n");
    800022c8:	00007517          	auipc	a0,0x7
    800022cc:	ec850513          	addi	a0,a0,-312 # 80009190 <_ZTV12ConsumerSync+0x110>
    800022d0:	00001097          	auipc	ra,0x1
    800022d4:	218080e7          	jalr	536(ra) # 800034e8 <_Z11printStringPKc>
    800022d8:	00000613          	li	a2,0
    800022dc:	00a00593          	li	a1,10
    800022e0:	00048513          	mv	a0,s1
    800022e4:	00001097          	auipc	ra,0x1
    800022e8:	3b0080e7          	jalr	944(ra) # 80003694 <_Z8printIntiii>
    800022ec:	00007517          	auipc	a0,0x7
    800022f0:	18c50513          	addi	a0,a0,396 # 80009478 <_ZTV8Consumer+0x1a0>
    800022f4:	00001097          	auipc	ra,0x1
    800022f8:	1f4080e7          	jalr	500(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800022fc:	0014849b          	addiw	s1,s1,1
    80002300:	0ff4f493          	andi	s1,s1,255
    80002304:	fbdff06f          	j	800022c0 <_ZL11workerBodyDPv+0x1c>
    }

    printString("D: dispatch\n");
    80002308:	00007517          	auipc	a0,0x7
    8000230c:	e9050513          	addi	a0,a0,-368 # 80009198 <_ZTV12ConsumerSync+0x118>
    80002310:	00001097          	auipc	ra,0x1
    80002314:	1d8080e7          	jalr	472(ra) # 800034e8 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002318:	00500313          	li	t1,5
    thread_dispatch();
    8000231c:	00004097          	auipc	ra,0x4
    80002320:	a6c080e7          	jalr	-1428(ra) # 80005d88 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002324:	01000513          	li	a0,16
    80002328:	00000097          	auipc	ra,0x0
    8000232c:	f04080e7          	jalr	-252(ra) # 8000222c <_ZL9fibonaccim>
    80002330:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002334:	00007517          	auipc	a0,0x7
    80002338:	e7450513          	addi	a0,a0,-396 # 800091a8 <_ZTV12ConsumerSync+0x128>
    8000233c:	00001097          	auipc	ra,0x1
    80002340:	1ac080e7          	jalr	428(ra) # 800034e8 <_Z11printStringPKc>
    80002344:	00000613          	li	a2,0
    80002348:	00a00593          	li	a1,10
    8000234c:	0009051b          	sext.w	a0,s2
    80002350:	00001097          	auipc	ra,0x1
    80002354:	344080e7          	jalr	836(ra) # 80003694 <_Z8printIntiii>
    80002358:	00007517          	auipc	a0,0x7
    8000235c:	12050513          	addi	a0,a0,288 # 80009478 <_ZTV8Consumer+0x1a0>
    80002360:	00001097          	auipc	ra,0x1
    80002364:	188080e7          	jalr	392(ra) # 800034e8 <_Z11printStringPKc>

    for (; i < 16; i++) {
    80002368:	00f00793          	li	a5,15
    8000236c:	0497e263          	bltu	a5,s1,800023b0 <_ZL11workerBodyDPv+0x10c>
        printString("D: i="); printInt(i); printString("\n");
    80002370:	00007517          	auipc	a0,0x7
    80002374:	e2050513          	addi	a0,a0,-480 # 80009190 <_ZTV12ConsumerSync+0x110>
    80002378:	00001097          	auipc	ra,0x1
    8000237c:	170080e7          	jalr	368(ra) # 800034e8 <_Z11printStringPKc>
    80002380:	00000613          	li	a2,0
    80002384:	00a00593          	li	a1,10
    80002388:	00048513          	mv	a0,s1
    8000238c:	00001097          	auipc	ra,0x1
    80002390:	308080e7          	jalr	776(ra) # 80003694 <_Z8printIntiii>
    80002394:	00007517          	auipc	a0,0x7
    80002398:	0e450513          	addi	a0,a0,228 # 80009478 <_ZTV8Consumer+0x1a0>
    8000239c:	00001097          	auipc	ra,0x1
    800023a0:	14c080e7          	jalr	332(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800023a4:	0014849b          	addiw	s1,s1,1
    800023a8:	0ff4f493          	andi	s1,s1,255
    800023ac:	fbdff06f          	j	80002368 <_ZL11workerBodyDPv+0xc4>
    }

    printString("D finished!\n");
    800023b0:	00007517          	auipc	a0,0x7
    800023b4:	e0850513          	addi	a0,a0,-504 # 800091b8 <_ZTV12ConsumerSync+0x138>
    800023b8:	00001097          	auipc	ra,0x1
    800023bc:	130080e7          	jalr	304(ra) # 800034e8 <_Z11printStringPKc>
    finishedD = true;
    800023c0:	00100793          	li	a5,1
    800023c4:	00009717          	auipc	a4,0x9
    800023c8:	20f70c23          	sb	a5,536(a4) # 8000b5dc <_ZL9finishedD>
    thread_dispatch();
    800023cc:	00004097          	auipc	ra,0x4
    800023d0:	9bc080e7          	jalr	-1604(ra) # 80005d88 <_Z15thread_dispatchv>
}
    800023d4:	01813083          	ld	ra,24(sp)
    800023d8:	01013403          	ld	s0,16(sp)
    800023dc:	00813483          	ld	s1,8(sp)
    800023e0:	00013903          	ld	s2,0(sp)
    800023e4:	02010113          	addi	sp,sp,32
    800023e8:	00008067          	ret

00000000800023ec <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    800023ec:	fe010113          	addi	sp,sp,-32
    800023f0:	00113c23          	sd	ra,24(sp)
    800023f4:	00813823          	sd	s0,16(sp)
    800023f8:	00913423          	sd	s1,8(sp)
    800023fc:	01213023          	sd	s2,0(sp)
    80002400:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80002404:	00000493          	li	s1,0
    for (; i < 3; i++) {
    80002408:	00200793          	li	a5,2
    8000240c:	0497e263          	bltu	a5,s1,80002450 <_ZL11workerBodyCPv+0x64>
        printString("C: i="); printInt(i); printString("\n");
    80002410:	00007517          	auipc	a0,0x7
    80002414:	db850513          	addi	a0,a0,-584 # 800091c8 <_ZTV12ConsumerSync+0x148>
    80002418:	00001097          	auipc	ra,0x1
    8000241c:	0d0080e7          	jalr	208(ra) # 800034e8 <_Z11printStringPKc>
    80002420:	00000613          	li	a2,0
    80002424:	00a00593          	li	a1,10
    80002428:	00048513          	mv	a0,s1
    8000242c:	00001097          	auipc	ra,0x1
    80002430:	268080e7          	jalr	616(ra) # 80003694 <_Z8printIntiii>
    80002434:	00007517          	auipc	a0,0x7
    80002438:	04450513          	addi	a0,a0,68 # 80009478 <_ZTV8Consumer+0x1a0>
    8000243c:	00001097          	auipc	ra,0x1
    80002440:	0ac080e7          	jalr	172(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002444:	0014849b          	addiw	s1,s1,1
    80002448:	0ff4f493          	andi	s1,s1,255
    8000244c:	fbdff06f          	j	80002408 <_ZL11workerBodyCPv+0x1c>
    printString("C: dispatch\n");
    80002450:	00007517          	auipc	a0,0x7
    80002454:	d8050513          	addi	a0,a0,-640 # 800091d0 <_ZTV12ConsumerSync+0x150>
    80002458:	00001097          	auipc	ra,0x1
    8000245c:	090080e7          	jalr	144(ra) # 800034e8 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80002460:	00700313          	li	t1,7
    thread_dispatch();
    80002464:	00004097          	auipc	ra,0x4
    80002468:	924080e7          	jalr	-1756(ra) # 80005d88 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000246c:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80002470:	00007517          	auipc	a0,0x7
    80002474:	d7050513          	addi	a0,a0,-656 # 800091e0 <_ZTV12ConsumerSync+0x160>
    80002478:	00001097          	auipc	ra,0x1
    8000247c:	070080e7          	jalr	112(ra) # 800034e8 <_Z11printStringPKc>
    80002480:	00000613          	li	a2,0
    80002484:	00a00593          	li	a1,10
    80002488:	0009051b          	sext.w	a0,s2
    8000248c:	00001097          	auipc	ra,0x1
    80002490:	208080e7          	jalr	520(ra) # 80003694 <_Z8printIntiii>
    80002494:	00007517          	auipc	a0,0x7
    80002498:	fe450513          	addi	a0,a0,-28 # 80009478 <_ZTV8Consumer+0x1a0>
    8000249c:	00001097          	auipc	ra,0x1
    800024a0:	04c080e7          	jalr	76(ra) # 800034e8 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800024a4:	00c00513          	li	a0,12
    800024a8:	00000097          	auipc	ra,0x0
    800024ac:	d84080e7          	jalr	-636(ra) # 8000222c <_ZL9fibonaccim>
    800024b0:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800024b4:	00007517          	auipc	a0,0x7
    800024b8:	d3450513          	addi	a0,a0,-716 # 800091e8 <_ZTV12ConsumerSync+0x168>
    800024bc:	00001097          	auipc	ra,0x1
    800024c0:	02c080e7          	jalr	44(ra) # 800034e8 <_Z11printStringPKc>
    800024c4:	00000613          	li	a2,0
    800024c8:	00a00593          	li	a1,10
    800024cc:	0009051b          	sext.w	a0,s2
    800024d0:	00001097          	auipc	ra,0x1
    800024d4:	1c4080e7          	jalr	452(ra) # 80003694 <_Z8printIntiii>
    800024d8:	00007517          	auipc	a0,0x7
    800024dc:	fa050513          	addi	a0,a0,-96 # 80009478 <_ZTV8Consumer+0x1a0>
    800024e0:	00001097          	auipc	ra,0x1
    800024e4:	008080e7          	jalr	8(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800024e8:	00500793          	li	a5,5
    800024ec:	0497e263          	bltu	a5,s1,80002530 <_ZL11workerBodyCPv+0x144>
        printString("C: i="); printInt(i); printString("\n");
    800024f0:	00007517          	auipc	a0,0x7
    800024f4:	cd850513          	addi	a0,a0,-808 # 800091c8 <_ZTV12ConsumerSync+0x148>
    800024f8:	00001097          	auipc	ra,0x1
    800024fc:	ff0080e7          	jalr	-16(ra) # 800034e8 <_Z11printStringPKc>
    80002500:	00000613          	li	a2,0
    80002504:	00a00593          	li	a1,10
    80002508:	00048513          	mv	a0,s1
    8000250c:	00001097          	auipc	ra,0x1
    80002510:	188080e7          	jalr	392(ra) # 80003694 <_Z8printIntiii>
    80002514:	00007517          	auipc	a0,0x7
    80002518:	f6450513          	addi	a0,a0,-156 # 80009478 <_ZTV8Consumer+0x1a0>
    8000251c:	00001097          	auipc	ra,0x1
    80002520:	fcc080e7          	jalr	-52(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80002524:	0014849b          	addiw	s1,s1,1
    80002528:	0ff4f493          	andi	s1,s1,255
    8000252c:	fbdff06f          	j	800024e8 <_ZL11workerBodyCPv+0xfc>
    printString("A finished!\n");
    80002530:	00007517          	auipc	a0,0x7
    80002534:	cc850513          	addi	a0,a0,-824 # 800091f8 <_ZTV12ConsumerSync+0x178>
    80002538:	00001097          	auipc	ra,0x1
    8000253c:	fb0080e7          	jalr	-80(ra) # 800034e8 <_Z11printStringPKc>
    finishedC = true;
    80002540:	00100793          	li	a5,1
    80002544:	00009717          	auipc	a4,0x9
    80002548:	08f70ca3          	sb	a5,153(a4) # 8000b5dd <_ZL9finishedC>
    thread_dispatch();
    8000254c:	00004097          	auipc	ra,0x4
    80002550:	83c080e7          	jalr	-1988(ra) # 80005d88 <_Z15thread_dispatchv>
}
    80002554:	01813083          	ld	ra,24(sp)
    80002558:	01013403          	ld	s0,16(sp)
    8000255c:	00813483          	ld	s1,8(sp)
    80002560:	00013903          	ld	s2,0(sp)
    80002564:	02010113          	addi	sp,sp,32
    80002568:	00008067          	ret

000000008000256c <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    8000256c:	fe010113          	addi	sp,sp,-32
    80002570:	00113c23          	sd	ra,24(sp)
    80002574:	00813823          	sd	s0,16(sp)
    80002578:	00913423          	sd	s1,8(sp)
    8000257c:	01213023          	sd	s2,0(sp)
    80002580:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80002584:	00000913          	li	s2,0
    80002588:	0380006f          	j	800025c0 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    8000258c:	00003097          	auipc	ra,0x3
    80002590:	7fc080e7          	jalr	2044(ra) # 80005d88 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002594:	00148493          	addi	s1,s1,1
    80002598:	000027b7          	lui	a5,0x2
    8000259c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800025a0:	0097ee63          	bltu	a5,s1,800025bc <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800025a4:	00000713          	li	a4,0
    800025a8:	000077b7          	lui	a5,0x7
    800025ac:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800025b0:	fce7eee3          	bltu	a5,a4,8000258c <_ZL11workerBodyBPv+0x20>
    800025b4:	00170713          	addi	a4,a4,1
    800025b8:	ff1ff06f          	j	800025a8 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800025bc:	00190913          	addi	s2,s2,1
    800025c0:	00f00793          	li	a5,15
    800025c4:	0527e063          	bltu	a5,s2,80002604 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800025c8:	00007517          	auipc	a0,0x7
    800025cc:	c4050513          	addi	a0,a0,-960 # 80009208 <_ZTV12ConsumerSync+0x188>
    800025d0:	00001097          	auipc	ra,0x1
    800025d4:	f18080e7          	jalr	-232(ra) # 800034e8 <_Z11printStringPKc>
    800025d8:	00000613          	li	a2,0
    800025dc:	00a00593          	li	a1,10
    800025e0:	0009051b          	sext.w	a0,s2
    800025e4:	00001097          	auipc	ra,0x1
    800025e8:	0b0080e7          	jalr	176(ra) # 80003694 <_Z8printIntiii>
    800025ec:	00007517          	auipc	a0,0x7
    800025f0:	e8c50513          	addi	a0,a0,-372 # 80009478 <_ZTV8Consumer+0x1a0>
    800025f4:	00001097          	auipc	ra,0x1
    800025f8:	ef4080e7          	jalr	-268(ra) # 800034e8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800025fc:	00000493          	li	s1,0
    80002600:	f99ff06f          	j	80002598 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80002604:	00007517          	auipc	a0,0x7
    80002608:	c0c50513          	addi	a0,a0,-1012 # 80009210 <_ZTV12ConsumerSync+0x190>
    8000260c:	00001097          	auipc	ra,0x1
    80002610:	edc080e7          	jalr	-292(ra) # 800034e8 <_Z11printStringPKc>
    finishedB = true;
    80002614:	00100793          	li	a5,1
    80002618:	00009717          	auipc	a4,0x9
    8000261c:	fcf70323          	sb	a5,-58(a4) # 8000b5de <_ZL9finishedB>
    thread_dispatch();
    80002620:	00003097          	auipc	ra,0x3
    80002624:	768080e7          	jalr	1896(ra) # 80005d88 <_Z15thread_dispatchv>
}
    80002628:	01813083          	ld	ra,24(sp)
    8000262c:	01013403          	ld	s0,16(sp)
    80002630:	00813483          	ld	s1,8(sp)
    80002634:	00013903          	ld	s2,0(sp)
    80002638:	02010113          	addi	sp,sp,32
    8000263c:	00008067          	ret

0000000080002640 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80002640:	fe010113          	addi	sp,sp,-32
    80002644:	00113c23          	sd	ra,24(sp)
    80002648:	00813823          	sd	s0,16(sp)
    8000264c:	00913423          	sd	s1,8(sp)
    80002650:	01213023          	sd	s2,0(sp)
    80002654:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80002658:	00000913          	li	s2,0
    8000265c:	0380006f          	j	80002694 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80002660:	00003097          	auipc	ra,0x3
    80002664:	728080e7          	jalr	1832(ra) # 80005d88 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002668:	00148493          	addi	s1,s1,1
    8000266c:	000027b7          	lui	a5,0x2
    80002670:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002674:	0097ee63          	bltu	a5,s1,80002690 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002678:	00000713          	li	a4,0
    8000267c:	000077b7          	lui	a5,0x7
    80002680:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002684:	fce7eee3          	bltu	a5,a4,80002660 <_ZL11workerBodyAPv+0x20>
    80002688:	00170713          	addi	a4,a4,1
    8000268c:	ff1ff06f          	j	8000267c <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80002690:	00190913          	addi	s2,s2,1
    80002694:	00900793          	li	a5,9
    80002698:	0527e063          	bltu	a5,s2,800026d8 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    8000269c:	00007517          	auipc	a0,0x7
    800026a0:	b8450513          	addi	a0,a0,-1148 # 80009220 <_ZTV12ConsumerSync+0x1a0>
    800026a4:	00001097          	auipc	ra,0x1
    800026a8:	e44080e7          	jalr	-444(ra) # 800034e8 <_Z11printStringPKc>
    800026ac:	00000613          	li	a2,0
    800026b0:	00a00593          	li	a1,10
    800026b4:	0009051b          	sext.w	a0,s2
    800026b8:	00001097          	auipc	ra,0x1
    800026bc:	fdc080e7          	jalr	-36(ra) # 80003694 <_Z8printIntiii>
    800026c0:	00007517          	auipc	a0,0x7
    800026c4:	db850513          	addi	a0,a0,-584 # 80009478 <_ZTV8Consumer+0x1a0>
    800026c8:	00001097          	auipc	ra,0x1
    800026cc:	e20080e7          	jalr	-480(ra) # 800034e8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800026d0:	00000493          	li	s1,0
    800026d4:	f99ff06f          	j	8000266c <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800026d8:	00007517          	auipc	a0,0x7
    800026dc:	b2050513          	addi	a0,a0,-1248 # 800091f8 <_ZTV12ConsumerSync+0x178>
    800026e0:	00001097          	auipc	ra,0x1
    800026e4:	e08080e7          	jalr	-504(ra) # 800034e8 <_Z11printStringPKc>
    finishedA = true;
    800026e8:	00100793          	li	a5,1
    800026ec:	00009717          	auipc	a4,0x9
    800026f0:	eef709a3          	sb	a5,-269(a4) # 8000b5df <_ZL9finishedA>
}
    800026f4:	01813083          	ld	ra,24(sp)
    800026f8:	01013403          	ld	s0,16(sp)
    800026fc:	00813483          	ld	s1,8(sp)
    80002700:	00013903          	ld	s2,0(sp)
    80002704:	02010113          	addi	sp,sp,32
    80002708:	00008067          	ret

000000008000270c <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    8000270c:	fd010113          	addi	sp,sp,-48
    80002710:	02113423          	sd	ra,40(sp)
    80002714:	02813023          	sd	s0,32(sp)
    80002718:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000271c:	00000613          	li	a2,0
    80002720:	00000597          	auipc	a1,0x0
    80002724:	f2058593          	addi	a1,a1,-224 # 80002640 <_ZL11workerBodyAPv>
    80002728:	fd040513          	addi	a0,s0,-48
    8000272c:	00003097          	auipc	ra,0x3
    80002730:	5ac080e7          	jalr	1452(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80002734:	00007517          	auipc	a0,0x7
    80002738:	af450513          	addi	a0,a0,-1292 # 80009228 <_ZTV12ConsumerSync+0x1a8>
    8000273c:	00001097          	auipc	ra,0x1
    80002740:	dac080e7          	jalr	-596(ra) # 800034e8 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80002744:	00000613          	li	a2,0
    80002748:	00000597          	auipc	a1,0x0
    8000274c:	e2458593          	addi	a1,a1,-476 # 8000256c <_ZL11workerBodyBPv>
    80002750:	fd840513          	addi	a0,s0,-40
    80002754:	00003097          	auipc	ra,0x3
    80002758:	584080e7          	jalr	1412(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    8000275c:	00007517          	auipc	a0,0x7
    80002760:	ae450513          	addi	a0,a0,-1308 # 80009240 <_ZTV12ConsumerSync+0x1c0>
    80002764:	00001097          	auipc	ra,0x1
    80002768:	d84080e7          	jalr	-636(ra) # 800034e8 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000276c:	00000613          	li	a2,0
    80002770:	00000597          	auipc	a1,0x0
    80002774:	c7c58593          	addi	a1,a1,-900 # 800023ec <_ZL11workerBodyCPv>
    80002778:	fe040513          	addi	a0,s0,-32
    8000277c:	00003097          	auipc	ra,0x3
    80002780:	55c080e7          	jalr	1372(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80002784:	00007517          	auipc	a0,0x7
    80002788:	ad450513          	addi	a0,a0,-1324 # 80009258 <_ZTV12ConsumerSync+0x1d8>
    8000278c:	00001097          	auipc	ra,0x1
    80002790:	d5c080e7          	jalr	-676(ra) # 800034e8 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80002794:	00000613          	li	a2,0
    80002798:	00000597          	auipc	a1,0x0
    8000279c:	b0c58593          	addi	a1,a1,-1268 # 800022a4 <_ZL11workerBodyDPv>
    800027a0:	fe840513          	addi	a0,s0,-24
    800027a4:	00003097          	auipc	ra,0x3
    800027a8:	534080e7          	jalr	1332(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    800027ac:	00007517          	auipc	a0,0x7
    800027b0:	ac450513          	addi	a0,a0,-1340 # 80009270 <_ZTV12ConsumerSync+0x1f0>
    800027b4:	00001097          	auipc	ra,0x1
    800027b8:	d34080e7          	jalr	-716(ra) # 800034e8 <_Z11printStringPKc>
    800027bc:	00c0006f          	j	800027c8 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800027c0:	00003097          	auipc	ra,0x3
    800027c4:	5c8080e7          	jalr	1480(ra) # 80005d88 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800027c8:	00009797          	auipc	a5,0x9
    800027cc:	e1778793          	addi	a5,a5,-489 # 8000b5df <_ZL9finishedA>
    800027d0:	0007c783          	lbu	a5,0(a5)
    800027d4:	0ff7f793          	andi	a5,a5,255
    800027d8:	fe0784e3          	beqz	a5,800027c0 <_Z18Threads_C_API_testv+0xb4>
    800027dc:	00009797          	auipc	a5,0x9
    800027e0:	e0278793          	addi	a5,a5,-510 # 8000b5de <_ZL9finishedB>
    800027e4:	0007c783          	lbu	a5,0(a5)
    800027e8:	0ff7f793          	andi	a5,a5,255
    800027ec:	fc078ae3          	beqz	a5,800027c0 <_Z18Threads_C_API_testv+0xb4>
    800027f0:	00009797          	auipc	a5,0x9
    800027f4:	ded78793          	addi	a5,a5,-531 # 8000b5dd <_ZL9finishedC>
    800027f8:	0007c783          	lbu	a5,0(a5)
    800027fc:	0ff7f793          	andi	a5,a5,255
    80002800:	fc0780e3          	beqz	a5,800027c0 <_Z18Threads_C_API_testv+0xb4>
    80002804:	00009797          	auipc	a5,0x9
    80002808:	dd878793          	addi	a5,a5,-552 # 8000b5dc <_ZL9finishedD>
    8000280c:	0007c783          	lbu	a5,0(a5)
    80002810:	0ff7f793          	andi	a5,a5,255
    80002814:	fa0786e3          	beqz	a5,800027c0 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80002818:	02813083          	ld	ra,40(sp)
    8000281c:	02013403          	ld	s0,32(sp)
    80002820:	03010113          	addi	sp,sp,48
    80002824:	00008067          	ret

0000000080002828 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80002828:	fe010113          	addi	sp,sp,-32
    8000282c:	00113c23          	sd	ra,24(sp)
    80002830:	00813823          	sd	s0,16(sp)
    80002834:	00913423          	sd	s1,8(sp)
    80002838:	01213023          	sd	s2,0(sp)
    8000283c:	02010413          	addi	s0,sp,32
    80002840:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80002844:	00000913          	li	s2,0
    80002848:	00c0006f          	j	80002854 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    8000284c:	00003097          	auipc	ra,0x3
    80002850:	53c080e7          	jalr	1340(ra) # 80005d88 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80002854:	00003097          	auipc	ra,0x3
    80002858:	6dc080e7          	jalr	1756(ra) # 80005f30 <_Z4getcv>
    8000285c:	0005059b          	sext.w	a1,a0
    80002860:	01b00793          	li	a5,27
    80002864:	02f58a63          	beq	a1,a5,80002898 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80002868:	0084b503          	ld	a0,8(s1)
    8000286c:	00001097          	auipc	ra,0x1
    80002870:	ff0080e7          	jalr	-16(ra) # 8000385c <_ZN6Buffer3putEi>
        i++;
    80002874:	0019079b          	addiw	a5,s2,1
    80002878:	0007891b          	sext.w	s2,a5
        if (i % (10 * data->id) == 0) {
    8000287c:	0004a683          	lw	a3,0(s1)
    80002880:	0026971b          	slliw	a4,a3,0x2
    80002884:	00d7073b          	addw	a4,a4,a3
    80002888:	0017169b          	slliw	a3,a4,0x1
    8000288c:	02d7e7bb          	remw	a5,a5,a3
    80002890:	fc0792e3          	bnez	a5,80002854 <_ZL16producerKeyboardPv+0x2c>
    80002894:	fb9ff06f          	j	8000284c <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80002898:	00100793          	li	a5,1
    8000289c:	00009717          	auipc	a4,0x9
    800028a0:	d4f72223          	sw	a5,-700(a4) # 8000b5e0 <_ZL9threadEnd>
    data->buffer->put('!');
    800028a4:	02100593          	li	a1,33
    800028a8:	0084b503          	ld	a0,8(s1)
    800028ac:	00001097          	auipc	ra,0x1
    800028b0:	fb0080e7          	jalr	-80(ra) # 8000385c <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    800028b4:	0104b503          	ld	a0,16(s1)
    800028b8:	00003097          	auipc	ra,0x3
    800028bc:	5cc080e7          	jalr	1484(ra) # 80005e84 <_Z10sem_signalP5mySem>
}
    800028c0:	01813083          	ld	ra,24(sp)
    800028c4:	01013403          	ld	s0,16(sp)
    800028c8:	00813483          	ld	s1,8(sp)
    800028cc:	00013903          	ld	s2,0(sp)
    800028d0:	02010113          	addi	sp,sp,32
    800028d4:	00008067          	ret

00000000800028d8 <_ZL8producerPv>:

static void producer(void *arg) {
    800028d8:	fe010113          	addi	sp,sp,-32
    800028dc:	00113c23          	sd	ra,24(sp)
    800028e0:	00813823          	sd	s0,16(sp)
    800028e4:	00913423          	sd	s1,8(sp)
    800028e8:	01213023          	sd	s2,0(sp)
    800028ec:	02010413          	addi	s0,sp,32
    800028f0:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800028f4:	00000913          	li	s2,0
    800028f8:	00c0006f          	j	80002904 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800028fc:	00003097          	auipc	ra,0x3
    80002900:	48c080e7          	jalr	1164(ra) # 80005d88 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80002904:	00009797          	auipc	a5,0x9
    80002908:	cdc78793          	addi	a5,a5,-804 # 8000b5e0 <_ZL9threadEnd>
    8000290c:	0007a783          	lw	a5,0(a5)
    80002910:	0007879b          	sext.w	a5,a5
    80002914:	02079e63          	bnez	a5,80002950 <_ZL8producerPv+0x78>
        data->buffer->put(data->id + '0');
    80002918:	0004a583          	lw	a1,0(s1)
    8000291c:	0305859b          	addiw	a1,a1,48
    80002920:	0084b503          	ld	a0,8(s1)
    80002924:	00001097          	auipc	ra,0x1
    80002928:	f38080e7          	jalr	-200(ra) # 8000385c <_ZN6Buffer3putEi>
        i++;
    8000292c:	0019079b          	addiw	a5,s2,1
    80002930:	0007891b          	sext.w	s2,a5
        if (i % (10 * data->id) == 0) {
    80002934:	0004a683          	lw	a3,0(s1)
    80002938:	0026971b          	slliw	a4,a3,0x2
    8000293c:	00d7073b          	addw	a4,a4,a3
    80002940:	0017169b          	slliw	a3,a4,0x1
    80002944:	02d7e7bb          	remw	a5,a5,a3
    80002948:	fa079ee3          	bnez	a5,80002904 <_ZL8producerPv+0x2c>
    8000294c:	fb1ff06f          	j	800028fc <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    80002950:	0104b503          	ld	a0,16(s1)
    80002954:	00003097          	auipc	ra,0x3
    80002958:	530080e7          	jalr	1328(ra) # 80005e84 <_Z10sem_signalP5mySem>
}
    8000295c:	01813083          	ld	ra,24(sp)
    80002960:	01013403          	ld	s0,16(sp)
    80002964:	00813483          	ld	s1,8(sp)
    80002968:	00013903          	ld	s2,0(sp)
    8000296c:	02010113          	addi	sp,sp,32
    80002970:	00008067          	ret

0000000080002974 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80002974:	fd010113          	addi	sp,sp,-48
    80002978:	02113423          	sd	ra,40(sp)
    8000297c:	02813023          	sd	s0,32(sp)
    80002980:	00913c23          	sd	s1,24(sp)
    80002984:	01213823          	sd	s2,16(sp)
    80002988:	01313423          	sd	s3,8(sp)
    8000298c:	03010413          	addi	s0,sp,48
    80002990:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002994:	00000993          	li	s3,0
    80002998:	01c0006f          	j	800029b4 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    8000299c:	00003097          	auipc	ra,0x3
    800029a0:	3ec080e7          	jalr	1004(ra) # 80005d88 <_Z15thread_dispatchv>
    800029a4:	0580006f          	j	800029fc <_ZL8consumerPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    800029a8:	00a00513          	li	a0,10
    800029ac:	00003097          	auipc	ra,0x3
    800029b0:	5b4080e7          	jalr	1460(ra) # 80005f60 <_Z4putcc>
    while (!threadEnd) {
    800029b4:	00009797          	auipc	a5,0x9
    800029b8:	c2c78793          	addi	a5,a5,-980 # 8000b5e0 <_ZL9threadEnd>
    800029bc:	0007a783          	lw	a5,0(a5)
    800029c0:	0007879b          	sext.w	a5,a5
    800029c4:	04079463          	bnez	a5,80002a0c <_ZL8consumerPv+0x98>
        int key = data->buffer->get();
    800029c8:	00893503          	ld	a0,8(s2)
    800029cc:	00001097          	auipc	ra,0x1
    800029d0:	f20080e7          	jalr	-224(ra) # 800038ec <_ZN6Buffer3getEv>
        i++;
    800029d4:	0019849b          	addiw	s1,s3,1
    800029d8:	0004899b          	sext.w	s3,s1
        putc(key);
    800029dc:	0ff57513          	andi	a0,a0,255
    800029e0:	00003097          	auipc	ra,0x3
    800029e4:	580080e7          	jalr	1408(ra) # 80005f60 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800029e8:	00092703          	lw	a4,0(s2)
    800029ec:	0027179b          	slliw	a5,a4,0x2
    800029f0:	00e787bb          	addw	a5,a5,a4
    800029f4:	02f4e7bb          	remw	a5,s1,a5
    800029f8:	fa0782e3          	beqz	a5,8000299c <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    800029fc:	05000793          	li	a5,80
    80002a00:	02f4e4bb          	remw	s1,s1,a5
    80002a04:	fa0498e3          	bnez	s1,800029b4 <_ZL8consumerPv+0x40>
    80002a08:	fa1ff06f          	j	800029a8 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
    80002a0c:	00893503          	ld	a0,8(s2)
    80002a10:	00001097          	auipc	ra,0x1
    80002a14:	f68080e7          	jalr	-152(ra) # 80003978 <_ZN6Buffer6getCntEv>
    80002a18:	02a05063          	blez	a0,80002a38 <_ZL8consumerPv+0xc4>
        int key = data->buffer->get();
    80002a1c:	00893503          	ld	a0,8(s2)
    80002a20:	00001097          	auipc	ra,0x1
    80002a24:	ecc080e7          	jalr	-308(ra) # 800038ec <_ZN6Buffer3getEv>
        putc(key);
    80002a28:	0ff57513          	andi	a0,a0,255
    80002a2c:	00003097          	auipc	ra,0x3
    80002a30:	534080e7          	jalr	1332(ra) # 80005f60 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80002a34:	fd9ff06f          	j	80002a0c <_ZL8consumerPv+0x98>
    }

    sem_signal(data->wait);
    80002a38:	01093503          	ld	a0,16(s2)
    80002a3c:	00003097          	auipc	ra,0x3
    80002a40:	448080e7          	jalr	1096(ra) # 80005e84 <_Z10sem_signalP5mySem>
}
    80002a44:	02813083          	ld	ra,40(sp)
    80002a48:	02013403          	ld	s0,32(sp)
    80002a4c:	01813483          	ld	s1,24(sp)
    80002a50:	01013903          	ld	s2,16(sp)
    80002a54:	00813983          	ld	s3,8(sp)
    80002a58:	03010113          	addi	sp,sp,48
    80002a5c:	00008067          	ret

0000000080002a60 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80002a60:	f9010113          	addi	sp,sp,-112
    80002a64:	06113423          	sd	ra,104(sp)
    80002a68:	06813023          	sd	s0,96(sp)
    80002a6c:	04913c23          	sd	s1,88(sp)
    80002a70:	05213823          	sd	s2,80(sp)
    80002a74:	05313423          	sd	s3,72(sp)
    80002a78:	05413023          	sd	s4,64(sp)
    80002a7c:	03513c23          	sd	s5,56(sp)
    80002a80:	03613823          	sd	s6,48(sp)
    80002a84:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80002a88:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80002a8c:	00006517          	auipc	a0,0x6
    80002a90:	61c50513          	addi	a0,a0,1564 # 800090a8 <_ZTV12ConsumerSync+0x28>
    80002a94:	00001097          	auipc	ra,0x1
    80002a98:	a54080e7          	jalr	-1452(ra) # 800034e8 <_Z11printStringPKc>
    getString(input, 30);
    80002a9c:	01e00593          	li	a1,30
    80002aa0:	fa040513          	addi	a0,s0,-96
    80002aa4:	00001097          	auipc	ra,0x1
    80002aa8:	acc080e7          	jalr	-1332(ra) # 80003570 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80002aac:	fa040513          	addi	a0,s0,-96
    80002ab0:	00001097          	auipc	ra,0x1
    80002ab4:	b94080e7          	jalr	-1132(ra) # 80003644 <_Z11stringToIntPKc>
    80002ab8:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80002abc:	00006517          	auipc	a0,0x6
    80002ac0:	60c50513          	addi	a0,a0,1548 # 800090c8 <_ZTV12ConsumerSync+0x48>
    80002ac4:	00001097          	auipc	ra,0x1
    80002ac8:	a24080e7          	jalr	-1500(ra) # 800034e8 <_Z11printStringPKc>
    getString(input, 30);
    80002acc:	01e00593          	li	a1,30
    80002ad0:	fa040513          	addi	a0,s0,-96
    80002ad4:	00001097          	auipc	ra,0x1
    80002ad8:	a9c080e7          	jalr	-1380(ra) # 80003570 <_Z9getStringPci>
    n = stringToInt(input);
    80002adc:	fa040513          	addi	a0,s0,-96
    80002ae0:	00001097          	auipc	ra,0x1
    80002ae4:	b64080e7          	jalr	-1180(ra) # 80003644 <_Z11stringToIntPKc>
    80002ae8:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80002aec:	00006517          	auipc	a0,0x6
    80002af0:	5fc50513          	addi	a0,a0,1532 # 800090e8 <_ZTV12ConsumerSync+0x68>
    80002af4:	00001097          	auipc	ra,0x1
    80002af8:	9f4080e7          	jalr	-1548(ra) # 800034e8 <_Z11printStringPKc>
    80002afc:	00000613          	li	a2,0
    80002b00:	00a00593          	li	a1,10
    80002b04:	00090513          	mv	a0,s2
    80002b08:	00001097          	auipc	ra,0x1
    80002b0c:	b8c080e7          	jalr	-1140(ra) # 80003694 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002b10:	00006517          	auipc	a0,0x6
    80002b14:	5f050513          	addi	a0,a0,1520 # 80009100 <_ZTV12ConsumerSync+0x80>
    80002b18:	00001097          	auipc	ra,0x1
    80002b1c:	9d0080e7          	jalr	-1584(ra) # 800034e8 <_Z11printStringPKc>
    80002b20:	00000613          	li	a2,0
    80002b24:	00a00593          	li	a1,10
    80002b28:	00048513          	mv	a0,s1
    80002b2c:	00001097          	auipc	ra,0x1
    80002b30:	b68080e7          	jalr	-1176(ra) # 80003694 <_Z8printIntiii>
    printString(".\n");
    80002b34:	00006517          	auipc	a0,0x6
    80002b38:	5e450513          	addi	a0,a0,1508 # 80009118 <_ZTV12ConsumerSync+0x98>
    80002b3c:	00001097          	auipc	ra,0x1
    80002b40:	9ac080e7          	jalr	-1620(ra) # 800034e8 <_Z11printStringPKc>
    if(threadNum > n) {
    80002b44:	0324c463          	blt	s1,s2,80002b6c <_Z22producerConsumer_C_APIv+0x10c>
    } else if (threadNum < 1) {
    80002b48:	03205c63          	blez	s2,80002b80 <_Z22producerConsumer_C_APIv+0x120>
    Buffer *buffer = new Buffer(n);
    80002b4c:	03800513          	li	a0,56
    80002b50:	00003097          	auipc	ra,0x3
    80002b54:	d98080e7          	jalr	-616(ra) # 800058e8 <_Znwm>
    80002b58:	00050a13          	mv	s4,a0
    80002b5c:	00048593          	mv	a1,s1
    80002b60:	00001097          	auipc	ra,0x1
    80002b64:	c60080e7          	jalr	-928(ra) # 800037c0 <_ZN6BufferC1Ei>
    80002b68:	0300006f          	j	80002b98 <_Z22producerConsumer_C_APIv+0x138>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002b6c:	00006517          	auipc	a0,0x6
    80002b70:	5b450513          	addi	a0,a0,1460 # 80009120 <_ZTV12ConsumerSync+0xa0>
    80002b74:	00001097          	auipc	ra,0x1
    80002b78:	974080e7          	jalr	-1676(ra) # 800034e8 <_Z11printStringPKc>
        return;
    80002b7c:	0140006f          	j	80002b90 <_Z22producerConsumer_C_APIv+0x130>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002b80:	00006517          	auipc	a0,0x6
    80002b84:	5e050513          	addi	a0,a0,1504 # 80009160 <_ZTV12ConsumerSync+0xe0>
    80002b88:	00001097          	auipc	ra,0x1
    80002b8c:	960080e7          	jalr	-1696(ra) # 800034e8 <_Z11printStringPKc>
        return;
    80002b90:	000b0113          	mv	sp,s6
    80002b94:	1680006f          	j	80002cfc <_Z22producerConsumer_C_APIv+0x29c>
    sem_open(&waitForAll, 0);
    80002b98:	00000593          	li	a1,0
    80002b9c:	00009517          	auipc	a0,0x9
    80002ba0:	a4c50513          	addi	a0,a0,-1460 # 8000b5e8 <_ZL10waitForAll>
    80002ba4:	00003097          	auipc	ra,0x3
    80002ba8:	234080e7          	jalr	564(ra) # 80005dd8 <_Z8sem_openPP5mySemj>
    thread_t threads[threadNum];
    80002bac:	00391793          	slli	a5,s2,0x3
    80002bb0:	00f78793          	addi	a5,a5,15
    80002bb4:	ff07f793          	andi	a5,a5,-16
    80002bb8:	40f10133          	sub	sp,sp,a5
    80002bbc:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80002bc0:	0019079b          	addiw	a5,s2,1
    80002bc4:	00179713          	slli	a4,a5,0x1
    80002bc8:	00f70733          	add	a4,a4,a5
    80002bcc:	00371793          	slli	a5,a4,0x3
    80002bd0:	00f78793          	addi	a5,a5,15
    80002bd4:	ff07f793          	andi	a5,a5,-16
    80002bd8:	40f10133          	sub	sp,sp,a5
    80002bdc:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80002be0:	00191713          	slli	a4,s2,0x1
    80002be4:	012706b3          	add	a3,a4,s2
    80002be8:	00369793          	slli	a5,a3,0x3
    80002bec:	00f987b3          	add	a5,s3,a5
    80002bf0:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80002bf4:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80002bf8:	00009697          	auipc	a3,0x9
    80002bfc:	9f068693          	addi	a3,a3,-1552 # 8000b5e8 <_ZL10waitForAll>
    80002c00:	0006b683          	ld	a3,0(a3)
    80002c04:	00d7b823          	sd	a3,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80002c08:	012707b3          	add	a5,a4,s2
    80002c0c:	00379613          	slli	a2,a5,0x3
    80002c10:	00c98633          	add	a2,s3,a2
    80002c14:	00000597          	auipc	a1,0x0
    80002c18:	d6058593          	addi	a1,a1,-672 # 80002974 <_ZL8consumerPv>
    80002c1c:	f9840513          	addi	a0,s0,-104
    80002c20:	00003097          	auipc	ra,0x3
    80002c24:	0b8080e7          	jalr	184(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002c28:	00000493          	li	s1,0
    80002c2c:	0280006f          	j	80002c54 <_Z22producerConsumer_C_APIv+0x1f4>
        thread_create(threads + i,
    80002c30:	00000597          	auipc	a1,0x0
    80002c34:	bf858593          	addi	a1,a1,-1032 # 80002828 <_ZL16producerKeyboardPv>
                      data + i);
    80002c38:	00171793          	slli	a5,a4,0x1
    80002c3c:	00e787b3          	add	a5,a5,a4
    80002c40:	00379613          	slli	a2,a5,0x3
        thread_create(threads + i,
    80002c44:	00c98633          	add	a2,s3,a2
    80002c48:	00003097          	auipc	ra,0x3
    80002c4c:	090080e7          	jalr	144(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002c50:	0014849b          	addiw	s1,s1,1
    80002c54:	0524d463          	bge	s1,s2,80002c9c <_Z22producerConsumer_C_APIv+0x23c>
        data[i].id = i;
    80002c58:	00149713          	slli	a4,s1,0x1
    80002c5c:	00970733          	add	a4,a4,s1
    80002c60:	00371793          	slli	a5,a4,0x3
    80002c64:	00f987b3          	add	a5,s3,a5
    80002c68:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80002c6c:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80002c70:	00009717          	auipc	a4,0x9
    80002c74:	97870713          	addi	a4,a4,-1672 # 8000b5e8 <_ZL10waitForAll>
    80002c78:	00073703          	ld	a4,0(a4)
    80002c7c:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80002c80:	00048713          	mv	a4,s1
    80002c84:	00349513          	slli	a0,s1,0x3
    80002c88:	00aa8533          	add	a0,s5,a0
    80002c8c:	fa9052e3          	blez	s1,80002c30 <_Z22producerConsumer_C_APIv+0x1d0>
    80002c90:	00000597          	auipc	a1,0x0
    80002c94:	c4858593          	addi	a1,a1,-952 # 800028d8 <_ZL8producerPv>
    80002c98:	fa1ff06f          	j	80002c38 <_Z22producerConsumer_C_APIv+0x1d8>
    thread_dispatch();
    80002c9c:	00003097          	auipc	ra,0x3
    80002ca0:	0ec080e7          	jalr	236(ra) # 80005d88 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80002ca4:	00000493          	li	s1,0
    80002ca8:	02994063          	blt	s2,s1,80002cc8 <_Z22producerConsumer_C_APIv+0x268>
        sem_wait(waitForAll);
    80002cac:	00009797          	auipc	a5,0x9
    80002cb0:	93c78793          	addi	a5,a5,-1732 # 8000b5e8 <_ZL10waitForAll>
    80002cb4:	0007b503          	ld	a0,0(a5)
    80002cb8:	00003097          	auipc	ra,0x3
    80002cbc:	194080e7          	jalr	404(ra) # 80005e4c <_Z8sem_waitP5mySem>
    for (int i = 0; i <= threadNum; i++) {
    80002cc0:	0014849b          	addiw	s1,s1,1
    80002cc4:	fe5ff06f          	j	80002ca8 <_Z22producerConsumer_C_APIv+0x248>
    sem_close(waitForAll);
    80002cc8:	00009797          	auipc	a5,0x9
    80002ccc:	92078793          	addi	a5,a5,-1760 # 8000b5e8 <_ZL10waitForAll>
    80002cd0:	0007b503          	ld	a0,0(a5)
    80002cd4:	00003097          	auipc	ra,0x3
    80002cd8:	140080e7          	jalr	320(ra) # 80005e14 <_Z9sem_closeP5mySem>
    delete buffer;
    80002cdc:	000a0e63          	beqz	s4,80002cf8 <_Z22producerConsumer_C_APIv+0x298>
    80002ce0:	000a0513          	mv	a0,s4
    80002ce4:	00001097          	auipc	ra,0x1
    80002ce8:	d1c080e7          	jalr	-740(ra) # 80003a00 <_ZN6BufferD1Ev>
    80002cec:	000a0513          	mv	a0,s4
    80002cf0:	00003097          	auipc	ra,0x3
    80002cf4:	c48080e7          	jalr	-952(ra) # 80005938 <_ZdlPv>
    80002cf8:	000b0113          	mv	sp,s6

}
    80002cfc:	f9040113          	addi	sp,s0,-112
    80002d00:	06813083          	ld	ra,104(sp)
    80002d04:	06013403          	ld	s0,96(sp)
    80002d08:	05813483          	ld	s1,88(sp)
    80002d0c:	05013903          	ld	s2,80(sp)
    80002d10:	04813983          	ld	s3,72(sp)
    80002d14:	04013a03          	ld	s4,64(sp)
    80002d18:	03813a83          	ld	s5,56(sp)
    80002d1c:	03013b03          	ld	s6,48(sp)
    80002d20:	07010113          	addi	sp,sp,112
    80002d24:	00008067          	ret
    80002d28:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80002d2c:	000a0513          	mv	a0,s4
    80002d30:	00003097          	auipc	ra,0x3
    80002d34:	c08080e7          	jalr	-1016(ra) # 80005938 <_ZdlPv>
    80002d38:	00048513          	mv	a0,s1
    80002d3c:	0000a097          	auipc	ra,0xa
    80002d40:	a3c080e7          	jalr	-1476(ra) # 8000c778 <_Unwind_Resume>

0000000080002d44 <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    80002d44:	f8010113          	addi	sp,sp,-128
    80002d48:	06113c23          	sd	ra,120(sp)
    80002d4c:	06813823          	sd	s0,112(sp)
    80002d50:	06913423          	sd	s1,104(sp)
    80002d54:	07213023          	sd	s2,96(sp)
    80002d58:	05313c23          	sd	s3,88(sp)
    80002d5c:	05413823          	sd	s4,80(sp)
    80002d60:	05513423          	sd	s5,72(sp)
    80002d64:	05613023          	sd	s6,64(sp)
    80002d68:	03713c23          	sd	s7,56(sp)
    80002d6c:	03813823          	sd	s8,48(sp)
    80002d70:	03913423          	sd	s9,40(sp)
    80002d74:	08010413          	addi	s0,sp,128
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    80002d78:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80002d7c:	00006517          	auipc	a0,0x6
    80002d80:	32c50513          	addi	a0,a0,812 # 800090a8 <_ZTV12ConsumerSync+0x28>
    80002d84:	00000097          	auipc	ra,0x0
    80002d88:	764080e7          	jalr	1892(ra) # 800034e8 <_Z11printStringPKc>
    getString(input, 30);
    80002d8c:	01e00593          	li	a1,30
    80002d90:	f8040513          	addi	a0,s0,-128
    80002d94:	00000097          	auipc	ra,0x0
    80002d98:	7dc080e7          	jalr	2012(ra) # 80003570 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80002d9c:	f8040513          	addi	a0,s0,-128
    80002da0:	00001097          	auipc	ra,0x1
    80002da4:	8a4080e7          	jalr	-1884(ra) # 80003644 <_Z11stringToIntPKc>
    80002da8:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80002dac:	00006517          	auipc	a0,0x6
    80002db0:	31c50513          	addi	a0,a0,796 # 800090c8 <_ZTV12ConsumerSync+0x48>
    80002db4:	00000097          	auipc	ra,0x0
    80002db8:	734080e7          	jalr	1844(ra) # 800034e8 <_Z11printStringPKc>
    getString(input, 30);
    80002dbc:	01e00593          	li	a1,30
    80002dc0:	f8040513          	addi	a0,s0,-128
    80002dc4:	00000097          	auipc	ra,0x0
    80002dc8:	7ac080e7          	jalr	1964(ra) # 80003570 <_Z9getStringPci>
    n = stringToInt(input);
    80002dcc:	f8040513          	addi	a0,s0,-128
    80002dd0:	00001097          	auipc	ra,0x1
    80002dd4:	874080e7          	jalr	-1932(ra) # 80003644 <_Z11stringToIntPKc>
    80002dd8:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    80002ddc:	00006517          	auipc	a0,0x6
    80002de0:	30c50513          	addi	a0,a0,780 # 800090e8 <_ZTV12ConsumerSync+0x68>
    80002de4:	00000097          	auipc	ra,0x0
    80002de8:	704080e7          	jalr	1796(ra) # 800034e8 <_Z11printStringPKc>
    printInt(threadNum);
    80002dec:	00000613          	li	a2,0
    80002df0:	00a00593          	li	a1,10
    80002df4:	00098513          	mv	a0,s3
    80002df8:	00001097          	auipc	ra,0x1
    80002dfc:	89c080e7          	jalr	-1892(ra) # 80003694 <_Z8printIntiii>
    printString(" i velicina bafera ");
    80002e00:	00006517          	auipc	a0,0x6
    80002e04:	30050513          	addi	a0,a0,768 # 80009100 <_ZTV12ConsumerSync+0x80>
    80002e08:	00000097          	auipc	ra,0x0
    80002e0c:	6e0080e7          	jalr	1760(ra) # 800034e8 <_Z11printStringPKc>
    printInt(n);
    80002e10:	00000613          	li	a2,0
    80002e14:	00a00593          	li	a1,10
    80002e18:	00048513          	mv	a0,s1
    80002e1c:	00001097          	auipc	ra,0x1
    80002e20:	878080e7          	jalr	-1928(ra) # 80003694 <_Z8printIntiii>
    printString(".\n");
    80002e24:	00006517          	auipc	a0,0x6
    80002e28:	2f450513          	addi	a0,a0,756 # 80009118 <_ZTV12ConsumerSync+0x98>
    80002e2c:	00000097          	auipc	ra,0x0
    80002e30:	6bc080e7          	jalr	1724(ra) # 800034e8 <_Z11printStringPKc>
    if (threadNum > n) {
    80002e34:	0334c463          	blt	s1,s3,80002e5c <_Z20testConsumerProducerv+0x118>
    } else if (threadNum < 1) {
    80002e38:	03305c63          	blez	s3,80002e70 <_Z20testConsumerProducerv+0x12c>
    BufferCPP *buffer = new BufferCPP(n);
    80002e3c:	03800513          	li	a0,56
    80002e40:	00003097          	auipc	ra,0x3
    80002e44:	aa8080e7          	jalr	-1368(ra) # 800058e8 <_Znwm>
    80002e48:	00050a93          	mv	s5,a0
    80002e4c:	00048593          	mv	a1,s1
    80002e50:	00001097          	auipc	ra,0x1
    80002e54:	c90080e7          	jalr	-880(ra) # 80003ae0 <_ZN9BufferCPPC1Ei>
    80002e58:	0300006f          	j	80002e88 <_Z20testConsumerProducerv+0x144>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002e5c:	00006517          	auipc	a0,0x6
    80002e60:	2c450513          	addi	a0,a0,708 # 80009120 <_ZTV12ConsumerSync+0xa0>
    80002e64:	00000097          	auipc	ra,0x0
    80002e68:	684080e7          	jalr	1668(ra) # 800034e8 <_Z11printStringPKc>
        return;
    80002e6c:	0140006f          	j	80002e80 <_Z20testConsumerProducerv+0x13c>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002e70:	00006517          	auipc	a0,0x6
    80002e74:	2f050513          	addi	a0,a0,752 # 80009160 <_ZTV12ConsumerSync+0xe0>
    80002e78:	00000097          	auipc	ra,0x0
    80002e7c:	670080e7          	jalr	1648(ra) # 800034e8 <_Z11printStringPKc>
        return;
    80002e80:	000b8113          	mv	sp,s7
    80002e84:	2240006f          	j	800030a8 <_Z20testConsumerProducerv+0x364>
    waitForAll = new Semaphore(0);
    80002e88:	01000513          	li	a0,16
    80002e8c:	00003097          	auipc	ra,0x3
    80002e90:	a5c080e7          	jalr	-1444(ra) # 800058e8 <_Znwm>
    80002e94:	00050913          	mv	s2,a0
    80002e98:	00000593          	li	a1,0
    80002e9c:	00002097          	auipc	ra,0x2
    80002ea0:	e30080e7          	jalr	-464(ra) # 80004ccc <_ZN9SemaphoreC1Ej>
    80002ea4:	00008797          	auipc	a5,0x8
    80002ea8:	7527ba23          	sd	s2,1876(a5) # 8000b5f8 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80002eac:	00399793          	slli	a5,s3,0x3
    80002eb0:	00f78793          	addi	a5,a5,15
    80002eb4:	ff07f793          	andi	a5,a5,-16
    80002eb8:	40f10133          	sub	sp,sp,a5
    80002ebc:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    80002ec0:	0019879b          	addiw	a5,s3,1
    80002ec4:	00179713          	slli	a4,a5,0x1
    80002ec8:	00f70733          	add	a4,a4,a5
    80002ecc:	00371793          	slli	a5,a4,0x3
    80002ed0:	00f78793          	addi	a5,a5,15
    80002ed4:	ff07f793          	andi	a5,a5,-16
    80002ed8:	40f10133          	sub	sp,sp,a5
    80002edc:	00010c13          	mv	s8,sp
    threadData[threadNum].id = threadNum;
    80002ee0:	00199793          	slli	a5,s3,0x1
    80002ee4:	013787b3          	add	a5,a5,s3
    80002ee8:	00379493          	slli	s1,a5,0x3
    80002eec:	009c04b3          	add	s1,s8,s1
    80002ef0:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    80002ef4:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    80002ef8:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80002efc:	02800513          	li	a0,40
    80002f00:	00003097          	auipc	ra,0x3
    80002f04:	9e8080e7          	jalr	-1560(ra) # 800058e8 <_Znwm>
    80002f08:	00050b13          	mv	s6,a0
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    80002f0c:	00002097          	auipc	ra,0x2
    80002f10:	cf8080e7          	jalr	-776(ra) # 80004c04 <_ZN6ThreadC1Ev>
    80002f14:	00006797          	auipc	a5,0x6
    80002f18:	3d478793          	addi	a5,a5,980 # 800092e8 <_ZTV8Consumer+0x10>
    80002f1c:	00fb3023          	sd	a5,0(s6)
    80002f20:	029b3023          	sd	s1,32(s6)
    consumer->start();
    80002f24:	000b0513          	mv	a0,s6
    80002f28:	00002097          	auipc	ra,0x2
    80002f2c:	c6c080e7          	jalr	-916(ra) # 80004b94 <_ZN6Thread5startEv>
    threadData[0].id = 0;
    80002f30:	000c2023          	sw	zero,0(s8)
    threadData[0].buffer = buffer;
    80002f34:	015c3423          	sd	s5,8(s8)
    threadData[0].sem = waitForAll;
    80002f38:	00008797          	auipc	a5,0x8
    80002f3c:	6c078793          	addi	a5,a5,1728 # 8000b5f8 <_ZL10waitForAll>
    80002f40:	0007b783          	ld	a5,0(a5)
    80002f44:	00fc3823          	sd	a5,16(s8)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80002f48:	02800513          	li	a0,40
    80002f4c:	00003097          	auipc	ra,0x3
    80002f50:	99c080e7          	jalr	-1636(ra) # 800058e8 <_Znwm>
    80002f54:	00050493          	mv	s1,a0
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80002f58:	00002097          	auipc	ra,0x2
    80002f5c:	cac080e7          	jalr	-852(ra) # 80004c04 <_ZN6ThreadC1Ev>
    80002f60:	00006797          	auipc	a5,0x6
    80002f64:	33878793          	addi	a5,a5,824 # 80009298 <_ZTV16ProducerKeyborad+0x10>
    80002f68:	00f4b023          	sd	a5,0(s1)
    80002f6c:	0384b023          	sd	s8,32(s1)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80002f70:	009a3023          	sd	s1,0(s4)
    producers[0]->start();
    80002f74:	00048513          	mv	a0,s1
    80002f78:	00002097          	auipc	ra,0x2
    80002f7c:	c1c080e7          	jalr	-996(ra) # 80004b94 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80002f80:	00100913          	li	s2,1
    80002f84:	0300006f          	j	80002fb4 <_Z20testConsumerProducerv+0x270>
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80002f88:	00006797          	auipc	a5,0x6
    80002f8c:	33878793          	addi	a5,a5,824 # 800092c0 <_ZTV8Producer+0x10>
    80002f90:	00fcb023          	sd	a5,0(s9)
    80002f94:	029cb023          	sd	s1,32(s9)
        producers[i] = new Producer(&threadData[i]);
    80002f98:	00391793          	slli	a5,s2,0x3
    80002f9c:	00fa07b3          	add	a5,s4,a5
    80002fa0:	0197b023          	sd	s9,0(a5)
        producers[i]->start();
    80002fa4:	000c8513          	mv	a0,s9
    80002fa8:	00002097          	auipc	ra,0x2
    80002fac:	bec080e7          	jalr	-1044(ra) # 80004b94 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80002fb0:	0019091b          	addiw	s2,s2,1
    80002fb4:	05395463          	bge	s2,s3,80002ffc <_Z20testConsumerProducerv+0x2b8>
        threadData[i].id = i;
    80002fb8:	00191793          	slli	a5,s2,0x1
    80002fbc:	012787b3          	add	a5,a5,s2
    80002fc0:	00379493          	slli	s1,a5,0x3
    80002fc4:	009c04b3          	add	s1,s8,s1
    80002fc8:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    80002fcc:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    80002fd0:	00008797          	auipc	a5,0x8
    80002fd4:	62878793          	addi	a5,a5,1576 # 8000b5f8 <_ZL10waitForAll>
    80002fd8:	0007b783          	ld	a5,0(a5)
    80002fdc:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    80002fe0:	02800513          	li	a0,40
    80002fe4:	00003097          	auipc	ra,0x3
    80002fe8:	904080e7          	jalr	-1788(ra) # 800058e8 <_Znwm>
    80002fec:	00050c93          	mv	s9,a0
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80002ff0:	00002097          	auipc	ra,0x2
    80002ff4:	c14080e7          	jalr	-1004(ra) # 80004c04 <_ZN6ThreadC1Ev>
    80002ff8:	f91ff06f          	j	80002f88 <_Z20testConsumerProducerv+0x244>
    Thread::dispatch();
    80002ffc:	00002097          	auipc	ra,0x2
    80003000:	be0080e7          	jalr	-1056(ra) # 80004bdc <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80003004:	00000493          	li	s1,0
    80003008:	0299c063          	blt	s3,s1,80003028 <_Z20testConsumerProducerv+0x2e4>
        waitForAll->wait();
    8000300c:	00008797          	auipc	a5,0x8
    80003010:	5ec78793          	addi	a5,a5,1516 # 8000b5f8 <_ZL10waitForAll>
    80003014:	0007b503          	ld	a0,0(a5)
    80003018:	00002097          	auipc	ra,0x2
    8000301c:	d1c080e7          	jalr	-740(ra) # 80004d34 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80003020:	0014849b          	addiw	s1,s1,1
    80003024:	fe5ff06f          	j	80003008 <_Z20testConsumerProducerv+0x2c4>
    delete waitForAll;
    80003028:	00008797          	auipc	a5,0x8
    8000302c:	5d078793          	addi	a5,a5,1488 # 8000b5f8 <_ZL10waitForAll>
    80003030:	0007b503          	ld	a0,0(a5)
    80003034:	00050863          	beqz	a0,80003044 <_Z20testConsumerProducerv+0x300>
    80003038:	00053783          	ld	a5,0(a0)
    8000303c:	0087b783          	ld	a5,8(a5)
    80003040:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    80003044:	00000493          	li	s1,0
    80003048:	0080006f          	j	80003050 <_Z20testConsumerProducerv+0x30c>
    for (int i = 0; i < threadNum; i++) {
    8000304c:	0014849b          	addiw	s1,s1,1
    80003050:	0334d263          	bge	s1,s3,80003074 <_Z20testConsumerProducerv+0x330>
        delete producers[i];
    80003054:	00349793          	slli	a5,s1,0x3
    80003058:	00fa07b3          	add	a5,s4,a5
    8000305c:	0007b503          	ld	a0,0(a5)
    80003060:	fe0506e3          	beqz	a0,8000304c <_Z20testConsumerProducerv+0x308>
    80003064:	00053783          	ld	a5,0(a0)
    80003068:	0087b783          	ld	a5,8(a5)
    8000306c:	000780e7          	jalr	a5
    80003070:	fddff06f          	j	8000304c <_Z20testConsumerProducerv+0x308>
    delete consumer;
    80003074:	000b0a63          	beqz	s6,80003088 <_Z20testConsumerProducerv+0x344>
    80003078:	000b3783          	ld	a5,0(s6)
    8000307c:	0087b783          	ld	a5,8(a5)
    80003080:	000b0513          	mv	a0,s6
    80003084:	000780e7          	jalr	a5
    delete buffer;
    80003088:	000a8e63          	beqz	s5,800030a4 <_Z20testConsumerProducerv+0x360>
    8000308c:	000a8513          	mv	a0,s5
    80003090:	00001097          	auipc	ra,0x1
    80003094:	d48080e7          	jalr	-696(ra) # 80003dd8 <_ZN9BufferCPPD1Ev>
    80003098:	000a8513          	mv	a0,s5
    8000309c:	00003097          	auipc	ra,0x3
    800030a0:	89c080e7          	jalr	-1892(ra) # 80005938 <_ZdlPv>
    800030a4:	000b8113          	mv	sp,s7
}
    800030a8:	f8040113          	addi	sp,s0,-128
    800030ac:	07813083          	ld	ra,120(sp)
    800030b0:	07013403          	ld	s0,112(sp)
    800030b4:	06813483          	ld	s1,104(sp)
    800030b8:	06013903          	ld	s2,96(sp)
    800030bc:	05813983          	ld	s3,88(sp)
    800030c0:	05013a03          	ld	s4,80(sp)
    800030c4:	04813a83          	ld	s5,72(sp)
    800030c8:	04013b03          	ld	s6,64(sp)
    800030cc:	03813b83          	ld	s7,56(sp)
    800030d0:	03013c03          	ld	s8,48(sp)
    800030d4:	02813c83          	ld	s9,40(sp)
    800030d8:	08010113          	addi	sp,sp,128
    800030dc:	00008067          	ret
    800030e0:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800030e4:	000a8513          	mv	a0,s5
    800030e8:	00003097          	auipc	ra,0x3
    800030ec:	850080e7          	jalr	-1968(ra) # 80005938 <_ZdlPv>
    800030f0:	00048513          	mv	a0,s1
    800030f4:	00009097          	auipc	ra,0x9
    800030f8:	684080e7          	jalr	1668(ra) # 8000c778 <_Unwind_Resume>
    800030fc:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    80003100:	00090513          	mv	a0,s2
    80003104:	00003097          	auipc	ra,0x3
    80003108:	834080e7          	jalr	-1996(ra) # 80005938 <_ZdlPv>
    8000310c:	00048513          	mv	a0,s1
    80003110:	00009097          	auipc	ra,0x9
    80003114:	668080e7          	jalr	1640(ra) # 8000c778 <_Unwind_Resume>
    80003118:	00050493          	mv	s1,a0
    Thread *consumer = new Consumer(&threadData[threadNum]);
    8000311c:	000b0513          	mv	a0,s6
    80003120:	00003097          	auipc	ra,0x3
    80003124:	818080e7          	jalr	-2024(ra) # 80005938 <_ZdlPv>
    80003128:	00048513          	mv	a0,s1
    8000312c:	00009097          	auipc	ra,0x9
    80003130:	64c080e7          	jalr	1612(ra) # 8000c778 <_Unwind_Resume>
    80003134:	00050913          	mv	s2,a0
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80003138:	00048513          	mv	a0,s1
    8000313c:	00002097          	auipc	ra,0x2
    80003140:	7fc080e7          	jalr	2044(ra) # 80005938 <_ZdlPv>
    80003144:	00090513          	mv	a0,s2
    80003148:	00009097          	auipc	ra,0x9
    8000314c:	630080e7          	jalr	1584(ra) # 8000c778 <_Unwind_Resume>
    80003150:	00050493          	mv	s1,a0
        producers[i] = new Producer(&threadData[i]);
    80003154:	000c8513          	mv	a0,s9
    80003158:	00002097          	auipc	ra,0x2
    8000315c:	7e0080e7          	jalr	2016(ra) # 80005938 <_ZdlPv>
    80003160:	00048513          	mv	a0,s1
    80003164:	00009097          	auipc	ra,0x9
    80003168:	614080e7          	jalr	1556(ra) # 8000c778 <_Unwind_Resume>

000000008000316c <_ZN8Consumer3runEv>:
    void run() override {
    8000316c:	fd010113          	addi	sp,sp,-48
    80003170:	02113423          	sd	ra,40(sp)
    80003174:	02813023          	sd	s0,32(sp)
    80003178:	00913c23          	sd	s1,24(sp)
    8000317c:	01213823          	sd	s2,16(sp)
    80003180:	01313423          	sd	s3,8(sp)
    80003184:	03010413          	addi	s0,sp,48
    80003188:	00050913          	mv	s2,a0
        int i = 0;
    8000318c:	00000993          	li	s3,0
    80003190:	0100006f          	j	800031a0 <_ZN8Consumer3runEv+0x34>
                Console::putc('\n');
    80003194:	00a00513          	li	a0,10
    80003198:	00002097          	auipc	ra,0x2
    8000319c:	c48080e7          	jalr	-952(ra) # 80004de0 <_ZN7Console4putcEc>
        while (!threadEnd) {
    800031a0:	00008797          	auipc	a5,0x8
    800031a4:	45078793          	addi	a5,a5,1104 # 8000b5f0 <_ZL9threadEnd>
    800031a8:	0007a783          	lw	a5,0(a5)
    800031ac:	0007879b          	sext.w	a5,a5
    800031b0:	02079c63          	bnez	a5,800031e8 <_ZN8Consumer3runEv+0x7c>
            int key = td->buffer->get();
    800031b4:	02093783          	ld	a5,32(s2)
    800031b8:	0087b503          	ld	a0,8(a5)
    800031bc:	00001097          	auipc	ra,0x1
    800031c0:	b08080e7          	jalr	-1272(ra) # 80003cc4 <_ZN9BufferCPP3getEv>
            i++;
    800031c4:	0019849b          	addiw	s1,s3,1
    800031c8:	0004899b          	sext.w	s3,s1
            Console::putc(key);
    800031cc:	0ff57513          	andi	a0,a0,255
    800031d0:	00002097          	auipc	ra,0x2
    800031d4:	c10080e7          	jalr	-1008(ra) # 80004de0 <_ZN7Console4putcEc>
            if (i % 80 == 0) {
    800031d8:	05000793          	li	a5,80
    800031dc:	02f4e4bb          	remw	s1,s1,a5
    800031e0:	fc0490e3          	bnez	s1,800031a0 <_ZN8Consumer3runEv+0x34>
    800031e4:	fb1ff06f          	j	80003194 <_ZN8Consumer3runEv+0x28>
        while (td->buffer->getCnt() > 0) {
    800031e8:	02093783          	ld	a5,32(s2)
    800031ec:	0087b503          	ld	a0,8(a5)
    800031f0:	00001097          	auipc	ra,0x1
    800031f4:	b60080e7          	jalr	-1184(ra) # 80003d50 <_ZN9BufferCPP6getCntEv>
    800031f8:	02a05263          	blez	a0,8000321c <_ZN8Consumer3runEv+0xb0>
            int key = td->buffer->get();
    800031fc:	02093783          	ld	a5,32(s2)
    80003200:	0087b503          	ld	a0,8(a5)
    80003204:	00001097          	auipc	ra,0x1
    80003208:	ac0080e7          	jalr	-1344(ra) # 80003cc4 <_ZN9BufferCPP3getEv>
            Console::putc(key);
    8000320c:	0ff57513          	andi	a0,a0,255
    80003210:	00002097          	auipc	ra,0x2
    80003214:	bd0080e7          	jalr	-1072(ra) # 80004de0 <_ZN7Console4putcEc>
        while (td->buffer->getCnt() > 0) {
    80003218:	fd1ff06f          	j	800031e8 <_ZN8Consumer3runEv+0x7c>
        td->sem->signal();
    8000321c:	02093783          	ld	a5,32(s2)
    80003220:	0107b503          	ld	a0,16(a5)
    80003224:	00002097          	auipc	ra,0x2
    80003228:	ae4080e7          	jalr	-1308(ra) # 80004d08 <_ZN9Semaphore6signalEv>
    }
    8000322c:	02813083          	ld	ra,40(sp)
    80003230:	02013403          	ld	s0,32(sp)
    80003234:	01813483          	ld	s1,24(sp)
    80003238:	01013903          	ld	s2,16(sp)
    8000323c:	00813983          	ld	s3,8(sp)
    80003240:	03010113          	addi	sp,sp,48
    80003244:	00008067          	ret

0000000080003248 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    80003248:	ff010113          	addi	sp,sp,-16
    8000324c:	00113423          	sd	ra,8(sp)
    80003250:	00813023          	sd	s0,0(sp)
    80003254:	01010413          	addi	s0,sp,16
    80003258:	00006797          	auipc	a5,0x6
    8000325c:	09078793          	addi	a5,a5,144 # 800092e8 <_ZTV8Consumer+0x10>
    80003260:	00f53023          	sd	a5,0(a0)
    80003264:	00001097          	auipc	ra,0x1
    80003268:	79c080e7          	jalr	1948(ra) # 80004a00 <_ZN6ThreadD1Ev>
    8000326c:	00813083          	ld	ra,8(sp)
    80003270:	00013403          	ld	s0,0(sp)
    80003274:	01010113          	addi	sp,sp,16
    80003278:	00008067          	ret

000000008000327c <_ZN8ConsumerD0Ev>:
    8000327c:	fe010113          	addi	sp,sp,-32
    80003280:	00113c23          	sd	ra,24(sp)
    80003284:	00813823          	sd	s0,16(sp)
    80003288:	00913423          	sd	s1,8(sp)
    8000328c:	02010413          	addi	s0,sp,32
    80003290:	00050493          	mv	s1,a0
    80003294:	00006797          	auipc	a5,0x6
    80003298:	05478793          	addi	a5,a5,84 # 800092e8 <_ZTV8Consumer+0x10>
    8000329c:	00f53023          	sd	a5,0(a0)
    800032a0:	00001097          	auipc	ra,0x1
    800032a4:	760080e7          	jalr	1888(ra) # 80004a00 <_ZN6ThreadD1Ev>
    800032a8:	00048513          	mv	a0,s1
    800032ac:	00002097          	auipc	ra,0x2
    800032b0:	68c080e7          	jalr	1676(ra) # 80005938 <_ZdlPv>
    800032b4:	01813083          	ld	ra,24(sp)
    800032b8:	01013403          	ld	s0,16(sp)
    800032bc:	00813483          	ld	s1,8(sp)
    800032c0:	02010113          	addi	sp,sp,32
    800032c4:	00008067          	ret

00000000800032c8 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    800032c8:	ff010113          	addi	sp,sp,-16
    800032cc:	00113423          	sd	ra,8(sp)
    800032d0:	00813023          	sd	s0,0(sp)
    800032d4:	01010413          	addi	s0,sp,16
    800032d8:	00006797          	auipc	a5,0x6
    800032dc:	fc078793          	addi	a5,a5,-64 # 80009298 <_ZTV16ProducerKeyborad+0x10>
    800032e0:	00f53023          	sd	a5,0(a0)
    800032e4:	00001097          	auipc	ra,0x1
    800032e8:	71c080e7          	jalr	1820(ra) # 80004a00 <_ZN6ThreadD1Ev>
    800032ec:	00813083          	ld	ra,8(sp)
    800032f0:	00013403          	ld	s0,0(sp)
    800032f4:	01010113          	addi	sp,sp,16
    800032f8:	00008067          	ret

00000000800032fc <_ZN16ProducerKeyboradD0Ev>:
    800032fc:	fe010113          	addi	sp,sp,-32
    80003300:	00113c23          	sd	ra,24(sp)
    80003304:	00813823          	sd	s0,16(sp)
    80003308:	00913423          	sd	s1,8(sp)
    8000330c:	02010413          	addi	s0,sp,32
    80003310:	00050493          	mv	s1,a0
    80003314:	00006797          	auipc	a5,0x6
    80003318:	f8478793          	addi	a5,a5,-124 # 80009298 <_ZTV16ProducerKeyborad+0x10>
    8000331c:	00f53023          	sd	a5,0(a0)
    80003320:	00001097          	auipc	ra,0x1
    80003324:	6e0080e7          	jalr	1760(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80003328:	00048513          	mv	a0,s1
    8000332c:	00002097          	auipc	ra,0x2
    80003330:	60c080e7          	jalr	1548(ra) # 80005938 <_ZdlPv>
    80003334:	01813083          	ld	ra,24(sp)
    80003338:	01013403          	ld	s0,16(sp)
    8000333c:	00813483          	ld	s1,8(sp)
    80003340:	02010113          	addi	sp,sp,32
    80003344:	00008067          	ret

0000000080003348 <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    80003348:	ff010113          	addi	sp,sp,-16
    8000334c:	00113423          	sd	ra,8(sp)
    80003350:	00813023          	sd	s0,0(sp)
    80003354:	01010413          	addi	s0,sp,16
    80003358:	00006797          	auipc	a5,0x6
    8000335c:	f6878793          	addi	a5,a5,-152 # 800092c0 <_ZTV8Producer+0x10>
    80003360:	00f53023          	sd	a5,0(a0)
    80003364:	00001097          	auipc	ra,0x1
    80003368:	69c080e7          	jalr	1692(ra) # 80004a00 <_ZN6ThreadD1Ev>
    8000336c:	00813083          	ld	ra,8(sp)
    80003370:	00013403          	ld	s0,0(sp)
    80003374:	01010113          	addi	sp,sp,16
    80003378:	00008067          	ret

000000008000337c <_ZN8ProducerD0Ev>:
    8000337c:	fe010113          	addi	sp,sp,-32
    80003380:	00113c23          	sd	ra,24(sp)
    80003384:	00813823          	sd	s0,16(sp)
    80003388:	00913423          	sd	s1,8(sp)
    8000338c:	02010413          	addi	s0,sp,32
    80003390:	00050493          	mv	s1,a0
    80003394:	00006797          	auipc	a5,0x6
    80003398:	f2c78793          	addi	a5,a5,-212 # 800092c0 <_ZTV8Producer+0x10>
    8000339c:	00f53023          	sd	a5,0(a0)
    800033a0:	00001097          	auipc	ra,0x1
    800033a4:	660080e7          	jalr	1632(ra) # 80004a00 <_ZN6ThreadD1Ev>
    800033a8:	00048513          	mv	a0,s1
    800033ac:	00002097          	auipc	ra,0x2
    800033b0:	58c080e7          	jalr	1420(ra) # 80005938 <_ZdlPv>
    800033b4:	01813083          	ld	ra,24(sp)
    800033b8:	01013403          	ld	s0,16(sp)
    800033bc:	00813483          	ld	s1,8(sp)
    800033c0:	02010113          	addi	sp,sp,32
    800033c4:	00008067          	ret

00000000800033c8 <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    800033c8:	fe010113          	addi	sp,sp,-32
    800033cc:	00113c23          	sd	ra,24(sp)
    800033d0:	00813823          	sd	s0,16(sp)
    800033d4:	00913423          	sd	s1,8(sp)
    800033d8:	02010413          	addi	s0,sp,32
    800033dc:	00050493          	mv	s1,a0
        while ((key = getc()) != 0x1b) {
    800033e0:	00003097          	auipc	ra,0x3
    800033e4:	b50080e7          	jalr	-1200(ra) # 80005f30 <_Z4getcv>
    800033e8:	0005059b          	sext.w	a1,a0
    800033ec:	01b00793          	li	a5,27
    800033f0:	00f58c63          	beq	a1,a5,80003408 <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    800033f4:	0204b783          	ld	a5,32(s1)
    800033f8:	0087b503          	ld	a0,8(a5)
    800033fc:	00001097          	auipc	ra,0x1
    80003400:	838080e7          	jalr	-1992(ra) # 80003c34 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 0x1b) {
    80003404:	fddff06f          	j	800033e0 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    80003408:	00100793          	li	a5,1
    8000340c:	00008717          	auipc	a4,0x8
    80003410:	1ef72223          	sw	a5,484(a4) # 8000b5f0 <_ZL9threadEnd>
        td->buffer->put('!');
    80003414:	0204b783          	ld	a5,32(s1)
    80003418:	02100593          	li	a1,33
    8000341c:	0087b503          	ld	a0,8(a5)
    80003420:	00001097          	auipc	ra,0x1
    80003424:	814080e7          	jalr	-2028(ra) # 80003c34 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    80003428:	0204b783          	ld	a5,32(s1)
    8000342c:	0107b503          	ld	a0,16(a5)
    80003430:	00002097          	auipc	ra,0x2
    80003434:	8d8080e7          	jalr	-1832(ra) # 80004d08 <_ZN9Semaphore6signalEv>
    }
    80003438:	01813083          	ld	ra,24(sp)
    8000343c:	01013403          	ld	s0,16(sp)
    80003440:	00813483          	ld	s1,8(sp)
    80003444:	02010113          	addi	sp,sp,32
    80003448:	00008067          	ret

000000008000344c <_ZN8Producer3runEv>:
    void run() override {
    8000344c:	fe010113          	addi	sp,sp,-32
    80003450:	00113c23          	sd	ra,24(sp)
    80003454:	00813823          	sd	s0,16(sp)
    80003458:	00913423          	sd	s1,8(sp)
    8000345c:	01213023          	sd	s2,0(sp)
    80003460:	02010413          	addi	s0,sp,32
    80003464:	00050493          	mv	s1,a0
        int i = 0;
    80003468:	00000913          	li	s2,0
        while (!threadEnd) {
    8000346c:	00008797          	auipc	a5,0x8
    80003470:	18478793          	addi	a5,a5,388 # 8000b5f0 <_ZL9threadEnd>
    80003474:	0007a783          	lw	a5,0(a5)
    80003478:	0007879b          	sext.w	a5,a5
    8000347c:	04079263          	bnez	a5,800034c0 <_ZN8Producer3runEv+0x74>
            td->buffer->put(td->id + '0');
    80003480:	0204b783          	ld	a5,32(s1)
    80003484:	0007a583          	lw	a1,0(a5)
    80003488:	0305859b          	addiw	a1,a1,48
    8000348c:	0087b503          	ld	a0,8(a5)
    80003490:	00000097          	auipc	ra,0x0
    80003494:	7a4080e7          	jalr	1956(ra) # 80003c34 <_ZN9BufferCPP3putEi>
            i++;
    80003498:	0019051b          	addiw	a0,s2,1
    8000349c:	0005091b          	sext.w	s2,a0
            Thread::sleep((i + td->id) % 5);
    800034a0:	0204b783          	ld	a5,32(s1)
    800034a4:	0007a783          	lw	a5,0(a5)
    800034a8:	00a787bb          	addw	a5,a5,a0
    800034ac:	00500513          	li	a0,5
    800034b0:	02a7e53b          	remw	a0,a5,a0
    800034b4:	00001097          	auipc	ra,0x1
    800034b8:	780080e7          	jalr	1920(ra) # 80004c34 <_ZN6Thread5sleepEm>
        while (!threadEnd) {
    800034bc:	fb1ff06f          	j	8000346c <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    800034c0:	0204b783          	ld	a5,32(s1)
    800034c4:	0107b503          	ld	a0,16(a5)
    800034c8:	00002097          	auipc	ra,0x2
    800034cc:	840080e7          	jalr	-1984(ra) # 80004d08 <_ZN9Semaphore6signalEv>
    }
    800034d0:	01813083          	ld	ra,24(sp)
    800034d4:	01013403          	ld	s0,16(sp)
    800034d8:	00813483          	ld	s1,8(sp)
    800034dc:	00013903          	ld	s2,0(sp)
    800034e0:	02010113          	addi	sp,sp,32
    800034e4:	00008067          	ret

00000000800034e8 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800034e8:	fe010113          	addi	sp,sp,-32
    800034ec:	00113c23          	sd	ra,24(sp)
    800034f0:	00813823          	sd	s0,16(sp)
    800034f4:	00913423          	sd	s1,8(sp)
    800034f8:	02010413          	addi	s0,sp,32
    800034fc:	00050493          	mv	s1,a0
    LOCK();
    80003500:	00100613          	li	a2,1
    80003504:	00000593          	li	a1,0
    80003508:	00008517          	auipc	a0,0x8
    8000350c:	0f850513          	addi	a0,a0,248 # 8000b600 <lockPrint>
    80003510:	ffffe097          	auipc	ra,0xffffe
    80003514:	af0080e7          	jalr	-1296(ra) # 80001000 <copy_and_swap>
    80003518:	00050863          	beqz	a0,80003528 <_Z11printStringPKc+0x40>
    8000351c:	00003097          	auipc	ra,0x3
    80003520:	86c080e7          	jalr	-1940(ra) # 80005d88 <_Z15thread_dispatchv>
    80003524:	fddff06f          	j	80003500 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80003528:	0004c503          	lbu	a0,0(s1)
    8000352c:	00050a63          	beqz	a0,80003540 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80003530:	00003097          	auipc	ra,0x3
    80003534:	a30080e7          	jalr	-1488(ra) # 80005f60 <_Z4putcc>
        string++;
    80003538:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000353c:	fedff06f          	j	80003528 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80003540:	00000613          	li	a2,0
    80003544:	00100593          	li	a1,1
    80003548:	00008517          	auipc	a0,0x8
    8000354c:	0b850513          	addi	a0,a0,184 # 8000b600 <lockPrint>
    80003550:	ffffe097          	auipc	ra,0xffffe
    80003554:	ab0080e7          	jalr	-1360(ra) # 80001000 <copy_and_swap>
    80003558:	fe0514e3          	bnez	a0,80003540 <_Z11printStringPKc+0x58>
}
    8000355c:	01813083          	ld	ra,24(sp)
    80003560:	01013403          	ld	s0,16(sp)
    80003564:	00813483          	ld	s1,8(sp)
    80003568:	02010113          	addi	sp,sp,32
    8000356c:	00008067          	ret

0000000080003570 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80003570:	fd010113          	addi	sp,sp,-48
    80003574:	02113423          	sd	ra,40(sp)
    80003578:	02813023          	sd	s0,32(sp)
    8000357c:	00913c23          	sd	s1,24(sp)
    80003580:	01213823          	sd	s2,16(sp)
    80003584:	01313423          	sd	s3,8(sp)
    80003588:	01413023          	sd	s4,0(sp)
    8000358c:	03010413          	addi	s0,sp,48
    80003590:	00050993          	mv	s3,a0
    80003594:	00058a13          	mv	s4,a1
    LOCK();
    80003598:	00100613          	li	a2,1
    8000359c:	00000593          	li	a1,0
    800035a0:	00008517          	auipc	a0,0x8
    800035a4:	06050513          	addi	a0,a0,96 # 8000b600 <lockPrint>
    800035a8:	ffffe097          	auipc	ra,0xffffe
    800035ac:	a58080e7          	jalr	-1448(ra) # 80001000 <copy_and_swap>
    800035b0:	00050863          	beqz	a0,800035c0 <_Z9getStringPci+0x50>
    800035b4:	00002097          	auipc	ra,0x2
    800035b8:	7d4080e7          	jalr	2004(ra) # 80005d88 <_Z15thread_dispatchv>
    800035bc:	fddff06f          	j	80003598 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800035c0:	00000493          	li	s1,0
    800035c4:	0014891b          	addiw	s2,s1,1
    800035c8:	03495a63          	bge	s2,s4,800035fc <_Z9getStringPci+0x8c>
        cc = getc();
    800035cc:	00003097          	auipc	ra,0x3
    800035d0:	964080e7          	jalr	-1692(ra) # 80005f30 <_Z4getcv>
        if(cc < 1)
    800035d4:	02050463          	beqz	a0,800035fc <_Z9getStringPci+0x8c>
            break;
        c = cc;
        buf[i++] = c;
    800035d8:	009984b3          	add	s1,s3,s1
    800035dc:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800035e0:	00a00793          	li	a5,10
    800035e4:	00f50a63          	beq	a0,a5,800035f8 <_Z9getStringPci+0x88>
        buf[i++] = c;
    800035e8:	00090493          	mv	s1,s2
        if(c == '\n' || c == '\r')
    800035ec:	00d00793          	li	a5,13
    800035f0:	fcf51ae3          	bne	a0,a5,800035c4 <_Z9getStringPci+0x54>
    800035f4:	0080006f          	j	800035fc <_Z9getStringPci+0x8c>
        buf[i++] = c;
    800035f8:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800035fc:	009984b3          	add	s1,s3,s1
    80003600:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80003604:	00000613          	li	a2,0
    80003608:	00100593          	li	a1,1
    8000360c:	00008517          	auipc	a0,0x8
    80003610:	ff450513          	addi	a0,a0,-12 # 8000b600 <lockPrint>
    80003614:	ffffe097          	auipc	ra,0xffffe
    80003618:	9ec080e7          	jalr	-1556(ra) # 80001000 <copy_and_swap>
    8000361c:	fe0514e3          	bnez	a0,80003604 <_Z9getStringPci+0x94>
    return buf;
}
    80003620:	00098513          	mv	a0,s3
    80003624:	02813083          	ld	ra,40(sp)
    80003628:	02013403          	ld	s0,32(sp)
    8000362c:	01813483          	ld	s1,24(sp)
    80003630:	01013903          	ld	s2,16(sp)
    80003634:	00813983          	ld	s3,8(sp)
    80003638:	00013a03          	ld	s4,0(sp)
    8000363c:	03010113          	addi	sp,sp,48
    80003640:	00008067          	ret

0000000080003644 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80003644:	ff010113          	addi	sp,sp,-16
    80003648:	00813423          	sd	s0,8(sp)
    8000364c:	01010413          	addi	s0,sp,16
    int n;

    n = 0;
    80003650:	00000793          	li	a5,0
    while ('0' <= *s && *s <= '9')
    80003654:	00054603          	lbu	a2,0(a0)
    80003658:	fd06069b          	addiw	a3,a2,-48
    8000365c:	0ff6f693          	andi	a3,a3,255
    80003660:	00900713          	li	a4,9
    80003664:	02d76063          	bltu	a4,a3,80003684 <_Z11stringToIntPKc+0x40>
        n = n * 10 + *s++ - '0';
    80003668:	0027969b          	slliw	a3,a5,0x2
    8000366c:	00f687bb          	addw	a5,a3,a5
    80003670:	0017971b          	slliw	a4,a5,0x1
    80003674:	00150513          	addi	a0,a0,1
    80003678:	00c707bb          	addw	a5,a4,a2
    8000367c:	fd07879b          	addiw	a5,a5,-48
    while ('0' <= *s && *s <= '9')
    80003680:	fd5ff06f          	j	80003654 <_Z11stringToIntPKc+0x10>
    return n;
}
    80003684:	00078513          	mv	a0,a5
    80003688:	00813403          	ld	s0,8(sp)
    8000368c:	01010113          	addi	sp,sp,16
    80003690:	00008067          	ret

0000000080003694 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80003694:	fc010113          	addi	sp,sp,-64
    80003698:	02113c23          	sd	ra,56(sp)
    8000369c:	02813823          	sd	s0,48(sp)
    800036a0:	02913423          	sd	s1,40(sp)
    800036a4:	03213023          	sd	s2,32(sp)
    800036a8:	01313c23          	sd	s3,24(sp)
    800036ac:	04010413          	addi	s0,sp,64
    800036b0:	00050493          	mv	s1,a0
    800036b4:	00058913          	mv	s2,a1
    800036b8:	00060993          	mv	s3,a2
    LOCK();
    800036bc:	00100613          	li	a2,1
    800036c0:	00000593          	li	a1,0
    800036c4:	00008517          	auipc	a0,0x8
    800036c8:	f3c50513          	addi	a0,a0,-196 # 8000b600 <lockPrint>
    800036cc:	ffffe097          	auipc	ra,0xffffe
    800036d0:	934080e7          	jalr	-1740(ra) # 80001000 <copy_and_swap>
    800036d4:	00050863          	beqz	a0,800036e4 <_Z8printIntiii+0x50>
    800036d8:	00002097          	auipc	ra,0x2
    800036dc:	6b0080e7          	jalr	1712(ra) # 80005d88 <_Z15thread_dispatchv>
    800036e0:	fddff06f          	j	800036bc <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800036e4:	00098463          	beqz	s3,800036ec <_Z8printIntiii+0x58>
    800036e8:	0004ca63          	bltz	s1,800036fc <_Z8printIntiii+0x68>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800036ec:	0004851b          	sext.w	a0,s1
    neg = 0;
    800036f0:	00000593          	li	a1,0
    }

    i = 0;
    800036f4:	00000613          	li	a2,0
    800036f8:	01c0006f          	j	80003714 <_Z8printIntiii+0x80>
        x = -xx;
    800036fc:	4090053b          	negw	a0,s1
    80003700:	0005051b          	sext.w	a0,a0
        neg = 1;
    80003704:	00100593          	li	a1,1
        x = -xx;
    80003708:	fedff06f          	j	800036f4 <_Z8printIntiii+0x60>
    do{
        buf[i++] = digits[x % base];
    }while((x /= base) != 0);
    8000370c:	00068513          	mv	a0,a3
        buf[i++] = digits[x % base];
    80003710:	00048613          	mv	a2,s1
    80003714:	0009079b          	sext.w	a5,s2
    80003718:	02f5773b          	remuw	a4,a0,a5
    8000371c:	0016049b          	addiw	s1,a2,1
    80003720:	02071693          	slli	a3,a4,0x20
    80003724:	0206d693          	srli	a3,a3,0x20
    80003728:	00008717          	auipc	a4,0x8
    8000372c:	e4870713          	addi	a4,a4,-440 # 8000b570 <digits>
    80003730:	00d70733          	add	a4,a4,a3
    80003734:	00074683          	lbu	a3,0(a4)
    80003738:	fd040713          	addi	a4,s0,-48
    8000373c:	00c70733          	add	a4,a4,a2
    80003740:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80003744:	02f5573b          	divuw	a4,a0,a5
    80003748:	0007069b          	sext.w	a3,a4
    8000374c:	fcf570e3          	bgeu	a0,a5,8000370c <_Z8printIntiii+0x78>
    if(neg)
    80003750:	00058c63          	beqz	a1,80003768 <_Z8printIntiii+0xd4>
        buf[i++] = '-';
    80003754:	fd040793          	addi	a5,s0,-48
    80003758:	009784b3          	add	s1,a5,s1
    8000375c:	02d00793          	li	a5,45
    80003760:	fef48823          	sb	a5,-16(s1)
    80003764:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80003768:	fff4849b          	addiw	s1,s1,-1
    8000376c:	0004ce63          	bltz	s1,80003788 <_Z8printIntiii+0xf4>
        putc(buf[i]);
    80003770:	fd040793          	addi	a5,s0,-48
    80003774:	009787b3          	add	a5,a5,s1
    80003778:	ff07c503          	lbu	a0,-16(a5)
    8000377c:	00002097          	auipc	ra,0x2
    80003780:	7e4080e7          	jalr	2020(ra) # 80005f60 <_Z4putcc>
    80003784:	fe5ff06f          	j	80003768 <_Z8printIntiii+0xd4>

    UNLOCK();
    80003788:	00000613          	li	a2,0
    8000378c:	00100593          	li	a1,1
    80003790:	00008517          	auipc	a0,0x8
    80003794:	e7050513          	addi	a0,a0,-400 # 8000b600 <lockPrint>
    80003798:	ffffe097          	auipc	ra,0xffffe
    8000379c:	868080e7          	jalr	-1944(ra) # 80001000 <copy_and_swap>
    800037a0:	fe0514e3          	bnez	a0,80003788 <_Z8printIntiii+0xf4>
    800037a4:	03813083          	ld	ra,56(sp)
    800037a8:	03013403          	ld	s0,48(sp)
    800037ac:	02813483          	ld	s1,40(sp)
    800037b0:	02013903          	ld	s2,32(sp)
    800037b4:	01813983          	ld	s3,24(sp)
    800037b8:	04010113          	addi	sp,sp,64
    800037bc:	00008067          	ret

00000000800037c0 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800037c0:	fe010113          	addi	sp,sp,-32
    800037c4:	00113c23          	sd	ra,24(sp)
    800037c8:	00813823          	sd	s0,16(sp)
    800037cc:	00913423          	sd	s1,8(sp)
    800037d0:	01213023          	sd	s2,0(sp)
    800037d4:	02010413          	addi	s0,sp,32
    800037d8:	00050493          	mv	s1,a0
    800037dc:	00058913          	mv	s2,a1
    800037e0:	0015879b          	addiw	a5,a1,1
    800037e4:	0007851b          	sext.w	a0,a5
    800037e8:	00f4a023          	sw	a5,0(s1)
    800037ec:	0004a823          	sw	zero,16(s1)
    800037f0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800037f4:	00251513          	slli	a0,a0,0x2
    800037f8:	00002097          	auipc	ra,0x2
    800037fc:	444080e7          	jalr	1092(ra) # 80005c3c <_Z9mem_allocm>
    80003800:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80003804:	00000593          	li	a1,0
    80003808:	02048513          	addi	a0,s1,32
    8000380c:	00002097          	auipc	ra,0x2
    80003810:	5cc080e7          	jalr	1484(ra) # 80005dd8 <_Z8sem_openPP5mySemj>
    sem_open(&spaceAvailable, _cap);
    80003814:	00090593          	mv	a1,s2
    80003818:	01848513          	addi	a0,s1,24
    8000381c:	00002097          	auipc	ra,0x2
    80003820:	5bc080e7          	jalr	1468(ra) # 80005dd8 <_Z8sem_openPP5mySemj>
    sem_open(&mutexHead, 1);
    80003824:	00100593          	li	a1,1
    80003828:	02848513          	addi	a0,s1,40
    8000382c:	00002097          	auipc	ra,0x2
    80003830:	5ac080e7          	jalr	1452(ra) # 80005dd8 <_Z8sem_openPP5mySemj>
    sem_open(&mutexTail, 1);
    80003834:	00100593          	li	a1,1
    80003838:	03048513          	addi	a0,s1,48
    8000383c:	00002097          	auipc	ra,0x2
    80003840:	59c080e7          	jalr	1436(ra) # 80005dd8 <_Z8sem_openPP5mySemj>
}
    80003844:	01813083          	ld	ra,24(sp)
    80003848:	01013403          	ld	s0,16(sp)
    8000384c:	00813483          	ld	s1,8(sp)
    80003850:	00013903          	ld	s2,0(sp)
    80003854:	02010113          	addi	sp,sp,32
    80003858:	00008067          	ret

000000008000385c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    8000385c:	fe010113          	addi	sp,sp,-32
    80003860:	00113c23          	sd	ra,24(sp)
    80003864:	00813823          	sd	s0,16(sp)
    80003868:	00913423          	sd	s1,8(sp)
    8000386c:	01213023          	sd	s2,0(sp)
    80003870:	02010413          	addi	s0,sp,32
    80003874:	00050493          	mv	s1,a0
    80003878:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    8000387c:	01853503          	ld	a0,24(a0)
    80003880:	00002097          	auipc	ra,0x2
    80003884:	5cc080e7          	jalr	1484(ra) # 80005e4c <_Z8sem_waitP5mySem>

    sem_wait(mutexTail);
    80003888:	0304b503          	ld	a0,48(s1)
    8000388c:	00002097          	auipc	ra,0x2
    80003890:	5c0080e7          	jalr	1472(ra) # 80005e4c <_Z8sem_waitP5mySem>
    buffer[tail] = val;
    80003894:	0084b783          	ld	a5,8(s1)
    80003898:	0144a703          	lw	a4,20(s1)
    8000389c:	00271713          	slli	a4,a4,0x2
    800038a0:	00e787b3          	add	a5,a5,a4
    800038a4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800038a8:	0144a783          	lw	a5,20(s1)
    800038ac:	0017879b          	addiw	a5,a5,1
    800038b0:	0004a703          	lw	a4,0(s1)
    800038b4:	02e7e7bb          	remw	a5,a5,a4
    800038b8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800038bc:	0304b503          	ld	a0,48(s1)
    800038c0:	00002097          	auipc	ra,0x2
    800038c4:	5c4080e7          	jalr	1476(ra) # 80005e84 <_Z10sem_signalP5mySem>

    sem_signal(itemAvailable);
    800038c8:	0204b503          	ld	a0,32(s1)
    800038cc:	00002097          	auipc	ra,0x2
    800038d0:	5b8080e7          	jalr	1464(ra) # 80005e84 <_Z10sem_signalP5mySem>

}
    800038d4:	01813083          	ld	ra,24(sp)
    800038d8:	01013403          	ld	s0,16(sp)
    800038dc:	00813483          	ld	s1,8(sp)
    800038e0:	00013903          	ld	s2,0(sp)
    800038e4:	02010113          	addi	sp,sp,32
    800038e8:	00008067          	ret

00000000800038ec <_ZN6Buffer3getEv>:

int Buffer::get() {
    800038ec:	fe010113          	addi	sp,sp,-32
    800038f0:	00113c23          	sd	ra,24(sp)
    800038f4:	00813823          	sd	s0,16(sp)
    800038f8:	00913423          	sd	s1,8(sp)
    800038fc:	01213023          	sd	s2,0(sp)
    80003900:	02010413          	addi	s0,sp,32
    80003904:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80003908:	02053503          	ld	a0,32(a0)
    8000390c:	00002097          	auipc	ra,0x2
    80003910:	540080e7          	jalr	1344(ra) # 80005e4c <_Z8sem_waitP5mySem>

    sem_wait(mutexHead);
    80003914:	0284b503          	ld	a0,40(s1)
    80003918:	00002097          	auipc	ra,0x2
    8000391c:	534080e7          	jalr	1332(ra) # 80005e4c <_Z8sem_waitP5mySem>

    int ret = buffer[head];
    80003920:	0084b703          	ld	a4,8(s1)
    80003924:	0104a783          	lw	a5,16(s1)
    80003928:	00279693          	slli	a3,a5,0x2
    8000392c:	00d70733          	add	a4,a4,a3
    80003930:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003934:	0017879b          	addiw	a5,a5,1
    80003938:	0004a703          	lw	a4,0(s1)
    8000393c:	02e7e7bb          	remw	a5,a5,a4
    80003940:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80003944:	0284b503          	ld	a0,40(s1)
    80003948:	00002097          	auipc	ra,0x2
    8000394c:	53c080e7          	jalr	1340(ra) # 80005e84 <_Z10sem_signalP5mySem>

    sem_signal(spaceAvailable);
    80003950:	0184b503          	ld	a0,24(s1)
    80003954:	00002097          	auipc	ra,0x2
    80003958:	530080e7          	jalr	1328(ra) # 80005e84 <_Z10sem_signalP5mySem>

    return ret;
}
    8000395c:	00090513          	mv	a0,s2
    80003960:	01813083          	ld	ra,24(sp)
    80003964:	01013403          	ld	s0,16(sp)
    80003968:	00813483          	ld	s1,8(sp)
    8000396c:	00013903          	ld	s2,0(sp)
    80003970:	02010113          	addi	sp,sp,32
    80003974:	00008067          	ret

0000000080003978 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80003978:	fe010113          	addi	sp,sp,-32
    8000397c:	00113c23          	sd	ra,24(sp)
    80003980:	00813823          	sd	s0,16(sp)
    80003984:	00913423          	sd	s1,8(sp)
    80003988:	01213023          	sd	s2,0(sp)
    8000398c:	02010413          	addi	s0,sp,32
    80003990:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80003994:	02853503          	ld	a0,40(a0)
    80003998:	00002097          	auipc	ra,0x2
    8000399c:	4b4080e7          	jalr	1204(ra) # 80005e4c <_Z8sem_waitP5mySem>
    sem_wait(mutexTail);
    800039a0:	0304b503          	ld	a0,48(s1)
    800039a4:	00002097          	auipc	ra,0x2
    800039a8:	4a8080e7          	jalr	1192(ra) # 80005e4c <_Z8sem_waitP5mySem>

    if (tail >= head) {
    800039ac:	0144a783          	lw	a5,20(s1)
    800039b0:	0104a903          	lw	s2,16(s1)
    800039b4:	0327ce63          	blt	a5,s2,800039f0 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800039b8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800039bc:	0304b503          	ld	a0,48(s1)
    800039c0:	00002097          	auipc	ra,0x2
    800039c4:	4c4080e7          	jalr	1220(ra) # 80005e84 <_Z10sem_signalP5mySem>
    sem_signal(mutexHead);
    800039c8:	0284b503          	ld	a0,40(s1)
    800039cc:	00002097          	auipc	ra,0x2
    800039d0:	4b8080e7          	jalr	1208(ra) # 80005e84 <_Z10sem_signalP5mySem>

    return ret;
}
    800039d4:	00090513          	mv	a0,s2
    800039d8:	01813083          	ld	ra,24(sp)
    800039dc:	01013403          	ld	s0,16(sp)
    800039e0:	00813483          	ld	s1,8(sp)
    800039e4:	00013903          	ld	s2,0(sp)
    800039e8:	02010113          	addi	sp,sp,32
    800039ec:	00008067          	ret
        ret = cap - head + tail;
    800039f0:	0004a703          	lw	a4,0(s1)
    800039f4:	4127093b          	subw	s2,a4,s2
    800039f8:	00f9093b          	addw	s2,s2,a5
    800039fc:	fc1ff06f          	j	800039bc <_ZN6Buffer6getCntEv+0x44>

0000000080003a00 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80003a00:	fe010113          	addi	sp,sp,-32
    80003a04:	00113c23          	sd	ra,24(sp)
    80003a08:	00813823          	sd	s0,16(sp)
    80003a0c:	00913423          	sd	s1,8(sp)
    80003a10:	02010413          	addi	s0,sp,32
    80003a14:	00050493          	mv	s1,a0
    putc('\n');
    80003a18:	00a00513          	li	a0,10
    80003a1c:	00002097          	auipc	ra,0x2
    80003a20:	544080e7          	jalr	1348(ra) # 80005f60 <_Z4putcc>
    printString("Buffer deleted!\n");
    80003a24:	00006517          	auipc	a0,0x6
    80003a28:	8dc50513          	addi	a0,a0,-1828 # 80009300 <_ZTV8Consumer+0x28>
    80003a2c:	00000097          	auipc	ra,0x0
    80003a30:	abc080e7          	jalr	-1348(ra) # 800034e8 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80003a34:	00048513          	mv	a0,s1
    80003a38:	00000097          	auipc	ra,0x0
    80003a3c:	f40080e7          	jalr	-192(ra) # 80003978 <_ZN6Buffer6getCntEv>
    80003a40:	02a05c63          	blez	a0,80003a78 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80003a44:	0084b783          	ld	a5,8(s1)
    80003a48:	0104a703          	lw	a4,16(s1)
    80003a4c:	00271713          	slli	a4,a4,0x2
    80003a50:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80003a54:	0007c503          	lbu	a0,0(a5)
    80003a58:	00002097          	auipc	ra,0x2
    80003a5c:	508080e7          	jalr	1288(ra) # 80005f60 <_Z4putcc>
        head = (head + 1) % cap;
    80003a60:	0104a783          	lw	a5,16(s1)
    80003a64:	0017879b          	addiw	a5,a5,1
    80003a68:	0004a703          	lw	a4,0(s1)
    80003a6c:	02e7e7bb          	remw	a5,a5,a4
    80003a70:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80003a74:	fc1ff06f          	j	80003a34 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80003a78:	02100513          	li	a0,33
    80003a7c:	00002097          	auipc	ra,0x2
    80003a80:	4e4080e7          	jalr	1252(ra) # 80005f60 <_Z4putcc>
    putc('\n');
    80003a84:	00a00513          	li	a0,10
    80003a88:	00002097          	auipc	ra,0x2
    80003a8c:	4d8080e7          	jalr	1240(ra) # 80005f60 <_Z4putcc>
    mem_free(buffer);
    80003a90:	0084b503          	ld	a0,8(s1)
    80003a94:	00002097          	auipc	ra,0x2
    80003a98:	200080e7          	jalr	512(ra) # 80005c94 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80003a9c:	0204b503          	ld	a0,32(s1)
    80003aa0:	00002097          	auipc	ra,0x2
    80003aa4:	374080e7          	jalr	884(ra) # 80005e14 <_Z9sem_closeP5mySem>
    sem_close(spaceAvailable);
    80003aa8:	0184b503          	ld	a0,24(s1)
    80003aac:	00002097          	auipc	ra,0x2
    80003ab0:	368080e7          	jalr	872(ra) # 80005e14 <_Z9sem_closeP5mySem>
    sem_close(mutexTail);
    80003ab4:	0304b503          	ld	a0,48(s1)
    80003ab8:	00002097          	auipc	ra,0x2
    80003abc:	35c080e7          	jalr	860(ra) # 80005e14 <_Z9sem_closeP5mySem>
    sem_close(mutexHead);
    80003ac0:	0284b503          	ld	a0,40(s1)
    80003ac4:	00002097          	auipc	ra,0x2
    80003ac8:	350080e7          	jalr	848(ra) # 80005e14 <_Z9sem_closeP5mySem>
}
    80003acc:	01813083          	ld	ra,24(sp)
    80003ad0:	01013403          	ld	s0,16(sp)
    80003ad4:	00813483          	ld	s1,8(sp)
    80003ad8:	02010113          	addi	sp,sp,32
    80003adc:	00008067          	ret

0000000080003ae0 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003ae0:	fd010113          	addi	sp,sp,-48
    80003ae4:	02113423          	sd	ra,40(sp)
    80003ae8:	02813023          	sd	s0,32(sp)
    80003aec:	00913c23          	sd	s1,24(sp)
    80003af0:	01213823          	sd	s2,16(sp)
    80003af4:	01313423          	sd	s3,8(sp)
    80003af8:	03010413          	addi	s0,sp,48
    80003afc:	00050493          	mv	s1,a0
    80003b00:	00058913          	mv	s2,a1
    80003b04:	0015879b          	addiw	a5,a1,1
    80003b08:	0007851b          	sext.w	a0,a5
    80003b0c:	00f4a023          	sw	a5,0(s1)
    80003b10:	0004a823          	sw	zero,16(s1)
    80003b14:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80003b18:	00251513          	slli	a0,a0,0x2
    80003b1c:	00002097          	auipc	ra,0x2
    80003b20:	120080e7          	jalr	288(ra) # 80005c3c <_Z9mem_allocm>
    80003b24:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80003b28:	01000513          	li	a0,16
    80003b2c:	00002097          	auipc	ra,0x2
    80003b30:	dbc080e7          	jalr	-580(ra) # 800058e8 <_Znwm>
    80003b34:	00050993          	mv	s3,a0
    80003b38:	00000593          	li	a1,0
    80003b3c:	00001097          	auipc	ra,0x1
    80003b40:	190080e7          	jalr	400(ra) # 80004ccc <_ZN9SemaphoreC1Ej>
    80003b44:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80003b48:	01000513          	li	a0,16
    80003b4c:	00002097          	auipc	ra,0x2
    80003b50:	d9c080e7          	jalr	-612(ra) # 800058e8 <_Znwm>
    80003b54:	00050993          	mv	s3,a0
    80003b58:	00090593          	mv	a1,s2
    80003b5c:	00001097          	auipc	ra,0x1
    80003b60:	170080e7          	jalr	368(ra) # 80004ccc <_ZN9SemaphoreC1Ej>
    80003b64:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80003b68:	01000513          	li	a0,16
    80003b6c:	00002097          	auipc	ra,0x2
    80003b70:	d7c080e7          	jalr	-644(ra) # 800058e8 <_Znwm>
    80003b74:	00050913          	mv	s2,a0
    80003b78:	00100593          	li	a1,1
    80003b7c:	00001097          	auipc	ra,0x1
    80003b80:	150080e7          	jalr	336(ra) # 80004ccc <_ZN9SemaphoreC1Ej>
    80003b84:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80003b88:	01000513          	li	a0,16
    80003b8c:	00002097          	auipc	ra,0x2
    80003b90:	d5c080e7          	jalr	-676(ra) # 800058e8 <_Znwm>
    80003b94:	00050913          	mv	s2,a0
    80003b98:	00100593          	li	a1,1
    80003b9c:	00001097          	auipc	ra,0x1
    80003ba0:	130080e7          	jalr	304(ra) # 80004ccc <_ZN9SemaphoreC1Ej>
    80003ba4:	0324b823          	sd	s2,48(s1)
}
    80003ba8:	02813083          	ld	ra,40(sp)
    80003bac:	02013403          	ld	s0,32(sp)
    80003bb0:	01813483          	ld	s1,24(sp)
    80003bb4:	01013903          	ld	s2,16(sp)
    80003bb8:	00813983          	ld	s3,8(sp)
    80003bbc:	03010113          	addi	sp,sp,48
    80003bc0:	00008067          	ret
    80003bc4:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80003bc8:	00098513          	mv	a0,s3
    80003bcc:	00002097          	auipc	ra,0x2
    80003bd0:	d6c080e7          	jalr	-660(ra) # 80005938 <_ZdlPv>
    80003bd4:	00048513          	mv	a0,s1
    80003bd8:	00009097          	auipc	ra,0x9
    80003bdc:	ba0080e7          	jalr	-1120(ra) # 8000c778 <_Unwind_Resume>
    80003be0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80003be4:	00098513          	mv	a0,s3
    80003be8:	00002097          	auipc	ra,0x2
    80003bec:	d50080e7          	jalr	-688(ra) # 80005938 <_ZdlPv>
    80003bf0:	00048513          	mv	a0,s1
    80003bf4:	00009097          	auipc	ra,0x9
    80003bf8:	b84080e7          	jalr	-1148(ra) # 8000c778 <_Unwind_Resume>
    80003bfc:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80003c00:	00090513          	mv	a0,s2
    80003c04:	00002097          	auipc	ra,0x2
    80003c08:	d34080e7          	jalr	-716(ra) # 80005938 <_ZdlPv>
    80003c0c:	00048513          	mv	a0,s1
    80003c10:	00009097          	auipc	ra,0x9
    80003c14:	b68080e7          	jalr	-1176(ra) # 8000c778 <_Unwind_Resume>
    80003c18:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80003c1c:	00090513          	mv	a0,s2
    80003c20:	00002097          	auipc	ra,0x2
    80003c24:	d18080e7          	jalr	-744(ra) # 80005938 <_ZdlPv>
    80003c28:	00048513          	mv	a0,s1
    80003c2c:	00009097          	auipc	ra,0x9
    80003c30:	b4c080e7          	jalr	-1204(ra) # 8000c778 <_Unwind_Resume>

0000000080003c34 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80003c34:	fe010113          	addi	sp,sp,-32
    80003c38:	00113c23          	sd	ra,24(sp)
    80003c3c:	00813823          	sd	s0,16(sp)
    80003c40:	00913423          	sd	s1,8(sp)
    80003c44:	01213023          	sd	s2,0(sp)
    80003c48:	02010413          	addi	s0,sp,32
    80003c4c:	00050493          	mv	s1,a0
    80003c50:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80003c54:	01853503          	ld	a0,24(a0)
    80003c58:	00001097          	auipc	ra,0x1
    80003c5c:	0dc080e7          	jalr	220(ra) # 80004d34 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80003c60:	0304b503          	ld	a0,48(s1)
    80003c64:	00001097          	auipc	ra,0x1
    80003c68:	0d0080e7          	jalr	208(ra) # 80004d34 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80003c6c:	0084b783          	ld	a5,8(s1)
    80003c70:	0144a703          	lw	a4,20(s1)
    80003c74:	00271713          	slli	a4,a4,0x2
    80003c78:	00e787b3          	add	a5,a5,a4
    80003c7c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003c80:	0144a783          	lw	a5,20(s1)
    80003c84:	0017879b          	addiw	a5,a5,1
    80003c88:	0004a703          	lw	a4,0(s1)
    80003c8c:	02e7e7bb          	remw	a5,a5,a4
    80003c90:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80003c94:	0304b503          	ld	a0,48(s1)
    80003c98:	00001097          	auipc	ra,0x1
    80003c9c:	070080e7          	jalr	112(ra) # 80004d08 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80003ca0:	0204b503          	ld	a0,32(s1)
    80003ca4:	00001097          	auipc	ra,0x1
    80003ca8:	064080e7          	jalr	100(ra) # 80004d08 <_ZN9Semaphore6signalEv>

}
    80003cac:	01813083          	ld	ra,24(sp)
    80003cb0:	01013403          	ld	s0,16(sp)
    80003cb4:	00813483          	ld	s1,8(sp)
    80003cb8:	00013903          	ld	s2,0(sp)
    80003cbc:	02010113          	addi	sp,sp,32
    80003cc0:	00008067          	ret

0000000080003cc4 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80003cc4:	fe010113          	addi	sp,sp,-32
    80003cc8:	00113c23          	sd	ra,24(sp)
    80003ccc:	00813823          	sd	s0,16(sp)
    80003cd0:	00913423          	sd	s1,8(sp)
    80003cd4:	01213023          	sd	s2,0(sp)
    80003cd8:	02010413          	addi	s0,sp,32
    80003cdc:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80003ce0:	02053503          	ld	a0,32(a0)
    80003ce4:	00001097          	auipc	ra,0x1
    80003ce8:	050080e7          	jalr	80(ra) # 80004d34 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80003cec:	0284b503          	ld	a0,40(s1)
    80003cf0:	00001097          	auipc	ra,0x1
    80003cf4:	044080e7          	jalr	68(ra) # 80004d34 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80003cf8:	0084b703          	ld	a4,8(s1)
    80003cfc:	0104a783          	lw	a5,16(s1)
    80003d00:	00279693          	slli	a3,a5,0x2
    80003d04:	00d70733          	add	a4,a4,a3
    80003d08:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003d0c:	0017879b          	addiw	a5,a5,1
    80003d10:	0004a703          	lw	a4,0(s1)
    80003d14:	02e7e7bb          	remw	a5,a5,a4
    80003d18:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80003d1c:	0284b503          	ld	a0,40(s1)
    80003d20:	00001097          	auipc	ra,0x1
    80003d24:	fe8080e7          	jalr	-24(ra) # 80004d08 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80003d28:	0184b503          	ld	a0,24(s1)
    80003d2c:	00001097          	auipc	ra,0x1
    80003d30:	fdc080e7          	jalr	-36(ra) # 80004d08 <_ZN9Semaphore6signalEv>

    return ret;
}
    80003d34:	00090513          	mv	a0,s2
    80003d38:	01813083          	ld	ra,24(sp)
    80003d3c:	01013403          	ld	s0,16(sp)
    80003d40:	00813483          	ld	s1,8(sp)
    80003d44:	00013903          	ld	s2,0(sp)
    80003d48:	02010113          	addi	sp,sp,32
    80003d4c:	00008067          	ret

0000000080003d50 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80003d50:	fe010113          	addi	sp,sp,-32
    80003d54:	00113c23          	sd	ra,24(sp)
    80003d58:	00813823          	sd	s0,16(sp)
    80003d5c:	00913423          	sd	s1,8(sp)
    80003d60:	01213023          	sd	s2,0(sp)
    80003d64:	02010413          	addi	s0,sp,32
    80003d68:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80003d6c:	02853503          	ld	a0,40(a0)
    80003d70:	00001097          	auipc	ra,0x1
    80003d74:	fc4080e7          	jalr	-60(ra) # 80004d34 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80003d78:	0304b503          	ld	a0,48(s1)
    80003d7c:	00001097          	auipc	ra,0x1
    80003d80:	fb8080e7          	jalr	-72(ra) # 80004d34 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80003d84:	0144a783          	lw	a5,20(s1)
    80003d88:	0104a903          	lw	s2,16(s1)
    80003d8c:	0327ce63          	blt	a5,s2,80003dc8 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80003d90:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80003d94:	0304b503          	ld	a0,48(s1)
    80003d98:	00001097          	auipc	ra,0x1
    80003d9c:	f70080e7          	jalr	-144(ra) # 80004d08 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80003da0:	0284b503          	ld	a0,40(s1)
    80003da4:	00001097          	auipc	ra,0x1
    80003da8:	f64080e7          	jalr	-156(ra) # 80004d08 <_ZN9Semaphore6signalEv>

    return ret;
}
    80003dac:	00090513          	mv	a0,s2
    80003db0:	01813083          	ld	ra,24(sp)
    80003db4:	01013403          	ld	s0,16(sp)
    80003db8:	00813483          	ld	s1,8(sp)
    80003dbc:	00013903          	ld	s2,0(sp)
    80003dc0:	02010113          	addi	sp,sp,32
    80003dc4:	00008067          	ret
        ret = cap - head + tail;
    80003dc8:	0004a703          	lw	a4,0(s1)
    80003dcc:	4127093b          	subw	s2,a4,s2
    80003dd0:	00f9093b          	addw	s2,s2,a5
    80003dd4:	fc1ff06f          	j	80003d94 <_ZN9BufferCPP6getCntEv+0x44>

0000000080003dd8 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80003dd8:	fe010113          	addi	sp,sp,-32
    80003ddc:	00113c23          	sd	ra,24(sp)
    80003de0:	00813823          	sd	s0,16(sp)
    80003de4:	00913423          	sd	s1,8(sp)
    80003de8:	02010413          	addi	s0,sp,32
    80003dec:	00050493          	mv	s1,a0
    Console::putc('\n');
    80003df0:	00a00513          	li	a0,10
    80003df4:	00001097          	auipc	ra,0x1
    80003df8:	fec080e7          	jalr	-20(ra) # 80004de0 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80003dfc:	00005517          	auipc	a0,0x5
    80003e00:	50450513          	addi	a0,a0,1284 # 80009300 <_ZTV8Consumer+0x28>
    80003e04:	fffff097          	auipc	ra,0xfffff
    80003e08:	6e4080e7          	jalr	1764(ra) # 800034e8 <_Z11printStringPKc>
    while (getCnt()) {
    80003e0c:	00048513          	mv	a0,s1
    80003e10:	00000097          	auipc	ra,0x0
    80003e14:	f40080e7          	jalr	-192(ra) # 80003d50 <_ZN9BufferCPP6getCntEv>
    80003e18:	02050c63          	beqz	a0,80003e50 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80003e1c:	0084b783          	ld	a5,8(s1)
    80003e20:	0104a703          	lw	a4,16(s1)
    80003e24:	00271713          	slli	a4,a4,0x2
    80003e28:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80003e2c:	0007c503          	lbu	a0,0(a5)
    80003e30:	00001097          	auipc	ra,0x1
    80003e34:	fb0080e7          	jalr	-80(ra) # 80004de0 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80003e38:	0104a783          	lw	a5,16(s1)
    80003e3c:	0017879b          	addiw	a5,a5,1
    80003e40:	0004a703          	lw	a4,0(s1)
    80003e44:	02e7e7bb          	remw	a5,a5,a4
    80003e48:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80003e4c:	fc1ff06f          	j	80003e0c <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80003e50:	02100513          	li	a0,33
    80003e54:	00001097          	auipc	ra,0x1
    80003e58:	f8c080e7          	jalr	-116(ra) # 80004de0 <_ZN7Console4putcEc>
    Console::putc('\n');
    80003e5c:	00a00513          	li	a0,10
    80003e60:	00001097          	auipc	ra,0x1
    80003e64:	f80080e7          	jalr	-128(ra) # 80004de0 <_ZN7Console4putcEc>
    mem_free(buffer);
    80003e68:	0084b503          	ld	a0,8(s1)
    80003e6c:	00002097          	auipc	ra,0x2
    80003e70:	e28080e7          	jalr	-472(ra) # 80005c94 <_Z8mem_freePv>
    delete itemAvailable;
    80003e74:	0204b503          	ld	a0,32(s1)
    80003e78:	00050863          	beqz	a0,80003e88 <_ZN9BufferCPPD1Ev+0xb0>
    80003e7c:	00053783          	ld	a5,0(a0)
    80003e80:	0087b783          	ld	a5,8(a5)
    80003e84:	000780e7          	jalr	a5
    delete spaceAvailable;
    80003e88:	0184b503          	ld	a0,24(s1)
    80003e8c:	00050863          	beqz	a0,80003e9c <_ZN9BufferCPPD1Ev+0xc4>
    80003e90:	00053783          	ld	a5,0(a0)
    80003e94:	0087b783          	ld	a5,8(a5)
    80003e98:	000780e7          	jalr	a5
    delete mutexTail;
    80003e9c:	0304b503          	ld	a0,48(s1)
    80003ea0:	00050863          	beqz	a0,80003eb0 <_ZN9BufferCPPD1Ev+0xd8>
    80003ea4:	00053783          	ld	a5,0(a0)
    80003ea8:	0087b783          	ld	a5,8(a5)
    80003eac:	000780e7          	jalr	a5
    delete mutexHead;
    80003eb0:	0284b503          	ld	a0,40(s1)
    80003eb4:	00050863          	beqz	a0,80003ec4 <_ZN9BufferCPPD1Ev+0xec>
    80003eb8:	00053783          	ld	a5,0(a0)
    80003ebc:	0087b783          	ld	a5,8(a5)
    80003ec0:	000780e7          	jalr	a5
}
    80003ec4:	01813083          	ld	ra,24(sp)
    80003ec8:	01013403          	ld	s0,16(sp)
    80003ecc:	00813483          	ld	s1,8(sp)
    80003ed0:	02010113          	addi	sp,sp,32
    80003ed4:	00008067          	ret

0000000080003ed8 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    80003ed8:	fe010113          	addi	sp,sp,-32
    80003edc:	00113c23          	sd	ra,24(sp)
    80003ee0:	00813823          	sd	s0,16(sp)
    80003ee4:	00913423          	sd	s1,8(sp)
    80003ee8:	01213023          	sd	s2,0(sp)
    80003eec:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80003ef0:	00005517          	auipc	a0,0x5
    80003ef4:	44850513          	addi	a0,a0,1096 # 80009338 <_ZTV8Consumer+0x60>
    80003ef8:	fffff097          	auipc	ra,0xfffff
    80003efc:	5f0080e7          	jalr	1520(ra) # 800034e8 <_Z11printStringPKc>
    int test = getc() - '0';
    80003f00:	00002097          	auipc	ra,0x2
    80003f04:	030080e7          	jalr	48(ra) # 80005f30 <_Z4getcv>
    80003f08:	fd05049b          	addiw	s1,a0,-48
    80003f0c:	0004891b          	sext.w	s2,s1
    getc(); // Enter posle broja
    80003f10:	00002097          	auipc	ra,0x2
    80003f14:	020080e7          	jalr	32(ra) # 80005f30 <_Z4getcv>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80003f18:	00700793          	li	a5,7
    80003f1c:	1127e863          	bltu	a5,s2,8000402c <_Z8userMainv+0x154>
    80003f20:	02049493          	slli	s1,s1,0x20
    80003f24:	0204d493          	srli	s1,s1,0x20
    80003f28:	00249493          	slli	s1,s1,0x2
    80003f2c:	00005717          	auipc	a4,0x5
    80003f30:	3e870713          	addi	a4,a4,1000 # 80009314 <_ZTV8Consumer+0x3c>
    80003f34:	00e484b3          	add	s1,s1,a4
    80003f38:	0004a783          	lw	a5,0(s1)
    80003f3c:	00e787b3          	add	a5,a5,a4
    80003f40:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    80003f44:	ffffe097          	auipc	ra,0xffffe
    80003f48:	7c8080e7          	jalr	1992(ra) # 8000270c <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80003f4c:	00005517          	auipc	a0,0x5
    80003f50:	40c50513          	addi	a0,a0,1036 # 80009358 <_ZTV8Consumer+0x80>
    80003f54:	fffff097          	auipc	ra,0xfffff
    80003f58:	594080e7          	jalr	1428(ra) # 800034e8 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
}
    80003f5c:	01813083          	ld	ra,24(sp)
    80003f60:	01013403          	ld	s0,16(sp)
    80003f64:	00813483          	ld	s1,8(sp)
    80003f68:	00013903          	ld	s2,0(sp)
    80003f6c:	02010113          	addi	sp,sp,32
    80003f70:	00008067          	ret
            Threads_CPP_API_test();
    80003f74:	00000097          	auipc	ra,0x0
    80003f78:	5ac080e7          	jalr	1452(ra) # 80004520 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80003f7c:	00005517          	auipc	a0,0x5
    80003f80:	41c50513          	addi	a0,a0,1052 # 80009398 <_ZTV8Consumer+0xc0>
    80003f84:	fffff097          	auipc	ra,0xfffff
    80003f88:	564080e7          	jalr	1380(ra) # 800034e8 <_Z11printStringPKc>
            break;
    80003f8c:	fd1ff06f          	j	80003f5c <_Z8userMainv+0x84>
            producerConsumer_C_API();
    80003f90:	fffff097          	auipc	ra,0xfffff
    80003f94:	ad0080e7          	jalr	-1328(ra) # 80002a60 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80003f98:	00005517          	auipc	a0,0x5
    80003f9c:	44050513          	addi	a0,a0,1088 # 800093d8 <_ZTV8Consumer+0x100>
    80003fa0:	fffff097          	auipc	ra,0xfffff
    80003fa4:	548080e7          	jalr	1352(ra) # 800034e8 <_Z11printStringPKc>
            break;
    80003fa8:	fb5ff06f          	j	80003f5c <_Z8userMainv+0x84>
            producerConsumer_CPP_Sync_API();
    80003fac:	ffffd097          	auipc	ra,0xffffd
    80003fb0:	628080e7          	jalr	1576(ra) # 800015d4 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80003fb4:	00005517          	auipc	a0,0x5
    80003fb8:	47450513          	addi	a0,a0,1140 # 80009428 <_ZTV8Consumer+0x150>
    80003fbc:	fffff097          	auipc	ra,0xfffff
    80003fc0:	52c080e7          	jalr	1324(ra) # 800034e8 <_Z11printStringPKc>
            break;
    80003fc4:	f99ff06f          	j	80003f5c <_Z8userMainv+0x84>
            testSleeping();
    80003fc8:	ffffd097          	auipc	ra,0xffffd
    80003fcc:	318080e7          	jalr	792(ra) # 800012e0 <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    80003fd0:	00005517          	auipc	a0,0x5
    80003fd4:	4b050513          	addi	a0,a0,1200 # 80009480 <_ZTV8Consumer+0x1a8>
    80003fd8:	fffff097          	auipc	ra,0xfffff
    80003fdc:	510080e7          	jalr	1296(ra) # 800034e8 <_Z11printStringPKc>
            break;
    80003fe0:	f7dff06f          	j	80003f5c <_Z8userMainv+0x84>
            testConsumerProducer();
    80003fe4:	fffff097          	auipc	ra,0xfffff
    80003fe8:	d60080e7          	jalr	-672(ra) # 80002d44 <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    80003fec:	00005517          	auipc	a0,0x5
    80003ff0:	4c450513          	addi	a0,a0,1220 # 800094b0 <_ZTV8Consumer+0x1d8>
    80003ff4:	fffff097          	auipc	ra,0xfffff
    80003ff8:	4f4080e7          	jalr	1268(ra) # 800034e8 <_Z11printStringPKc>
            break;
    80003ffc:	f61ff06f          	j	80003f5c <_Z8userMainv+0x84>
            System_Mode_test();
    80004000:	ffffe097          	auipc	ra,0xffffe
    80004004:	110080e7          	jalr	272(ra) # 80002110 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80004008:	00005517          	auipc	a0,0x5
    8000400c:	4e850513          	addi	a0,a0,1256 # 800094f0 <_ZTV8Consumer+0x218>
    80004010:	fffff097          	auipc	ra,0xfffff
    80004014:	4d8080e7          	jalr	1240(ra) # 800034e8 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80004018:	00005517          	auipc	a0,0x5
    8000401c:	4f850513          	addi	a0,a0,1272 # 80009510 <_ZTV8Consumer+0x238>
    80004020:	fffff097          	auipc	ra,0xfffff
    80004024:	4c8080e7          	jalr	1224(ra) # 800034e8 <_Z11printStringPKc>
            break;
    80004028:	f35ff06f          	j	80003f5c <_Z8userMainv+0x84>
            printString("Niste uneli odgovarajuci broj za test\n");
    8000402c:	00005517          	auipc	a0,0x5
    80004030:	53c50513          	addi	a0,a0,1340 # 80009568 <_ZTV8Consumer+0x290>
    80004034:	fffff097          	auipc	ra,0xfffff
    80004038:	4b4080e7          	jalr	1204(ra) # 800034e8 <_Z11printStringPKc>
    8000403c:	f21ff06f          	j	80003f5c <_Z8userMainv+0x84>

0000000080004040 <_ZL9fibonaccim>:
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    if (n == 0 || n == 1) { return n; }
    80004040:	00100793          	li	a5,1
    80004044:	06a7f863          	bgeu	a5,a0,800040b4 <_ZL9fibonaccim+0x74>
static uint64 fibonacci(uint64 n) {
    80004048:	fe010113          	addi	sp,sp,-32
    8000404c:	00113c23          	sd	ra,24(sp)
    80004050:	00813823          	sd	s0,16(sp)
    80004054:	00913423          	sd	s1,8(sp)
    80004058:	01213023          	sd	s2,0(sp)
    8000405c:	02010413          	addi	s0,sp,32
    80004060:	00050493          	mv	s1,a0
    if (n % 10 == 0) { thread_dispatch(); }
    80004064:	00a00793          	li	a5,10
    80004068:	02f577b3          	remu	a5,a0,a5
    8000406c:	02078e63          	beqz	a5,800040a8 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004070:	fff48513          	addi	a0,s1,-1
    80004074:	00000097          	auipc	ra,0x0
    80004078:	fcc080e7          	jalr	-52(ra) # 80004040 <_ZL9fibonaccim>
    8000407c:	00050913          	mv	s2,a0
    80004080:	ffe48513          	addi	a0,s1,-2
    80004084:	00000097          	auipc	ra,0x0
    80004088:	fbc080e7          	jalr	-68(ra) # 80004040 <_ZL9fibonaccim>
    8000408c:	00a90533          	add	a0,s2,a0
}
    80004090:	01813083          	ld	ra,24(sp)
    80004094:	01013403          	ld	s0,16(sp)
    80004098:	00813483          	ld	s1,8(sp)
    8000409c:	00013903          	ld	s2,0(sp)
    800040a0:	02010113          	addi	sp,sp,32
    800040a4:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800040a8:	00002097          	auipc	ra,0x2
    800040ac:	ce0080e7          	jalr	-800(ra) # 80005d88 <_Z15thread_dispatchv>
    800040b0:	fc1ff06f          	j	80004070 <_ZL9fibonaccim+0x30>
}
    800040b4:	00008067          	ret

00000000800040b8 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    800040b8:	fe010113          	addi	sp,sp,-32
    800040bc:	00113c23          	sd	ra,24(sp)
    800040c0:	00813823          	sd	s0,16(sp)
    800040c4:	00913423          	sd	s1,8(sp)
    800040c8:	01213023          	sd	s2,0(sp)
    800040cc:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800040d0:	00000913          	li	s2,0
    800040d4:	0380006f          	j	8000410c <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800040d8:	00002097          	auipc	ra,0x2
    800040dc:	cb0080e7          	jalr	-848(ra) # 80005d88 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800040e0:	00148493          	addi	s1,s1,1
    800040e4:	000027b7          	lui	a5,0x2
    800040e8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800040ec:	0097ee63          	bltu	a5,s1,80004108 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800040f0:	00000713          	li	a4,0
    800040f4:	000077b7          	lui	a5,0x7
    800040f8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800040fc:	fce7eee3          	bltu	a5,a4,800040d8 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80004100:	00170713          	addi	a4,a4,1
    80004104:	ff1ff06f          	j	800040f4 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004108:	00190913          	addi	s2,s2,1
    8000410c:	00900793          	li	a5,9
    80004110:	0527e063          	bltu	a5,s2,80004150 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004114:	00005517          	auipc	a0,0x5
    80004118:	10c50513          	addi	a0,a0,268 # 80009220 <_ZTV12ConsumerSync+0x1a0>
    8000411c:	fffff097          	auipc	ra,0xfffff
    80004120:	3cc080e7          	jalr	972(ra) # 800034e8 <_Z11printStringPKc>
    80004124:	00000613          	li	a2,0
    80004128:	00a00593          	li	a1,10
    8000412c:	0009051b          	sext.w	a0,s2
    80004130:	fffff097          	auipc	ra,0xfffff
    80004134:	564080e7          	jalr	1380(ra) # 80003694 <_Z8printIntiii>
    80004138:	00005517          	auipc	a0,0x5
    8000413c:	34050513          	addi	a0,a0,832 # 80009478 <_ZTV8Consumer+0x1a0>
    80004140:	fffff097          	auipc	ra,0xfffff
    80004144:	3a8080e7          	jalr	936(ra) # 800034e8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004148:	00000493          	li	s1,0
    8000414c:	f99ff06f          	j	800040e4 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80004150:	00005517          	auipc	a0,0x5
    80004154:	0a850513          	addi	a0,a0,168 # 800091f8 <_ZTV12ConsumerSync+0x178>
    80004158:	fffff097          	auipc	ra,0xfffff
    8000415c:	390080e7          	jalr	912(ra) # 800034e8 <_Z11printStringPKc>
    finishedA = true;
    80004160:	00100793          	li	a5,1
    80004164:	00007717          	auipc	a4,0x7
    80004168:	4af703a3          	sb	a5,1191(a4) # 8000b60b <_ZL9finishedA>
}
    8000416c:	01813083          	ld	ra,24(sp)
    80004170:	01013403          	ld	s0,16(sp)
    80004174:	00813483          	ld	s1,8(sp)
    80004178:	00013903          	ld	s2,0(sp)
    8000417c:	02010113          	addi	sp,sp,32
    80004180:	00008067          	ret

0000000080004184 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80004184:	fe010113          	addi	sp,sp,-32
    80004188:	00113c23          	sd	ra,24(sp)
    8000418c:	00813823          	sd	s0,16(sp)
    80004190:	00913423          	sd	s1,8(sp)
    80004194:	01213023          	sd	s2,0(sp)
    80004198:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000419c:	00000913          	li	s2,0
    800041a0:	0380006f          	j	800041d8 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800041a4:	00002097          	auipc	ra,0x2
    800041a8:	be4080e7          	jalr	-1052(ra) # 80005d88 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800041ac:	00148493          	addi	s1,s1,1
    800041b0:	000027b7          	lui	a5,0x2
    800041b4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800041b8:	0097ee63          	bltu	a5,s1,800041d4 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800041bc:	00000713          	li	a4,0
    800041c0:	000077b7          	lui	a5,0x7
    800041c4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800041c8:	fce7eee3          	bltu	a5,a4,800041a4 <_ZN7WorkerB11workerBodyBEPv+0x20>
    800041cc:	00170713          	addi	a4,a4,1
    800041d0:	ff1ff06f          	j	800041c0 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800041d4:	00190913          	addi	s2,s2,1
    800041d8:	00f00793          	li	a5,15
    800041dc:	0527e063          	bltu	a5,s2,8000421c <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800041e0:	00005517          	auipc	a0,0x5
    800041e4:	02850513          	addi	a0,a0,40 # 80009208 <_ZTV12ConsumerSync+0x188>
    800041e8:	fffff097          	auipc	ra,0xfffff
    800041ec:	300080e7          	jalr	768(ra) # 800034e8 <_Z11printStringPKc>
    800041f0:	00000613          	li	a2,0
    800041f4:	00a00593          	li	a1,10
    800041f8:	0009051b          	sext.w	a0,s2
    800041fc:	fffff097          	auipc	ra,0xfffff
    80004200:	498080e7          	jalr	1176(ra) # 80003694 <_Z8printIntiii>
    80004204:	00005517          	auipc	a0,0x5
    80004208:	27450513          	addi	a0,a0,628 # 80009478 <_ZTV8Consumer+0x1a0>
    8000420c:	fffff097          	auipc	ra,0xfffff
    80004210:	2dc080e7          	jalr	732(ra) # 800034e8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004214:	00000493          	li	s1,0
    80004218:	f99ff06f          	j	800041b0 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    8000421c:	00005517          	auipc	a0,0x5
    80004220:	ff450513          	addi	a0,a0,-12 # 80009210 <_ZTV12ConsumerSync+0x190>
    80004224:	fffff097          	auipc	ra,0xfffff
    80004228:	2c4080e7          	jalr	708(ra) # 800034e8 <_Z11printStringPKc>
    finishedB = true;
    8000422c:	00100793          	li	a5,1
    80004230:	00007717          	auipc	a4,0x7
    80004234:	3cf70d23          	sb	a5,986(a4) # 8000b60a <_ZL9finishedB>
    thread_dispatch();
    80004238:	00002097          	auipc	ra,0x2
    8000423c:	b50080e7          	jalr	-1200(ra) # 80005d88 <_Z15thread_dispatchv>
}
    80004240:	01813083          	ld	ra,24(sp)
    80004244:	01013403          	ld	s0,16(sp)
    80004248:	00813483          	ld	s1,8(sp)
    8000424c:	00013903          	ld	s2,0(sp)
    80004250:	02010113          	addi	sp,sp,32
    80004254:	00008067          	ret

0000000080004258 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80004258:	fe010113          	addi	sp,sp,-32
    8000425c:	00113c23          	sd	ra,24(sp)
    80004260:	00813823          	sd	s0,16(sp)
    80004264:	00913423          	sd	s1,8(sp)
    80004268:	01213023          	sd	s2,0(sp)
    8000426c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004270:	00000493          	li	s1,0
    for (; i < 3; i++) {
    80004274:	00200793          	li	a5,2
    80004278:	0497e263          	bltu	a5,s1,800042bc <_ZN7WorkerC11workerBodyCEPv+0x64>
        printString("C: i="); printInt(i); printString("\n");
    8000427c:	00005517          	auipc	a0,0x5
    80004280:	f4c50513          	addi	a0,a0,-180 # 800091c8 <_ZTV12ConsumerSync+0x148>
    80004284:	fffff097          	auipc	ra,0xfffff
    80004288:	264080e7          	jalr	612(ra) # 800034e8 <_Z11printStringPKc>
    8000428c:	00000613          	li	a2,0
    80004290:	00a00593          	li	a1,10
    80004294:	00048513          	mv	a0,s1
    80004298:	fffff097          	auipc	ra,0xfffff
    8000429c:	3fc080e7          	jalr	1020(ra) # 80003694 <_Z8printIntiii>
    800042a0:	00005517          	auipc	a0,0x5
    800042a4:	1d850513          	addi	a0,a0,472 # 80009478 <_ZTV8Consumer+0x1a0>
    800042a8:	fffff097          	auipc	ra,0xfffff
    800042ac:	240080e7          	jalr	576(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800042b0:	0014849b          	addiw	s1,s1,1
    800042b4:	0ff4f493          	andi	s1,s1,255
    800042b8:	fbdff06f          	j	80004274 <_ZN7WorkerC11workerBodyCEPv+0x1c>
    }

    printString("C: dispatch\n");
    800042bc:	00005517          	auipc	a0,0x5
    800042c0:	f1450513          	addi	a0,a0,-236 # 800091d0 <_ZTV12ConsumerSync+0x150>
    800042c4:	fffff097          	auipc	ra,0xfffff
    800042c8:	224080e7          	jalr	548(ra) # 800034e8 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800042cc:	00700313          	li	t1,7
    thread_dispatch();
    800042d0:	00002097          	auipc	ra,0x2
    800042d4:	ab8080e7          	jalr	-1352(ra) # 80005d88 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800042d8:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800042dc:	00005517          	auipc	a0,0x5
    800042e0:	f0450513          	addi	a0,a0,-252 # 800091e0 <_ZTV12ConsumerSync+0x160>
    800042e4:	fffff097          	auipc	ra,0xfffff
    800042e8:	204080e7          	jalr	516(ra) # 800034e8 <_Z11printStringPKc>
    800042ec:	00000613          	li	a2,0
    800042f0:	00a00593          	li	a1,10
    800042f4:	0009051b          	sext.w	a0,s2
    800042f8:	fffff097          	auipc	ra,0xfffff
    800042fc:	39c080e7          	jalr	924(ra) # 80003694 <_Z8printIntiii>
    80004300:	00005517          	auipc	a0,0x5
    80004304:	17850513          	addi	a0,a0,376 # 80009478 <_ZTV8Consumer+0x1a0>
    80004308:	fffff097          	auipc	ra,0xfffff
    8000430c:	1e0080e7          	jalr	480(ra) # 800034e8 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80004310:	00c00513          	li	a0,12
    80004314:	00000097          	auipc	ra,0x0
    80004318:	d2c080e7          	jalr	-724(ra) # 80004040 <_ZL9fibonaccim>
    8000431c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004320:	00005517          	auipc	a0,0x5
    80004324:	ec850513          	addi	a0,a0,-312 # 800091e8 <_ZTV12ConsumerSync+0x168>
    80004328:	fffff097          	auipc	ra,0xfffff
    8000432c:	1c0080e7          	jalr	448(ra) # 800034e8 <_Z11printStringPKc>
    80004330:	00000613          	li	a2,0
    80004334:	00a00593          	li	a1,10
    80004338:	0009051b          	sext.w	a0,s2
    8000433c:	fffff097          	auipc	ra,0xfffff
    80004340:	358080e7          	jalr	856(ra) # 80003694 <_Z8printIntiii>
    80004344:	00005517          	auipc	a0,0x5
    80004348:	13450513          	addi	a0,a0,308 # 80009478 <_ZTV8Consumer+0x1a0>
    8000434c:	fffff097          	auipc	ra,0xfffff
    80004350:	19c080e7          	jalr	412(ra) # 800034e8 <_Z11printStringPKc>

    for (; i < 6; i++) {
    80004354:	00500793          	li	a5,5
    80004358:	0497e263          	bltu	a5,s1,8000439c <_ZN7WorkerC11workerBodyCEPv+0x144>
        printString("C: i="); printInt(i); printString("\n");
    8000435c:	00005517          	auipc	a0,0x5
    80004360:	e6c50513          	addi	a0,a0,-404 # 800091c8 <_ZTV12ConsumerSync+0x148>
    80004364:	fffff097          	auipc	ra,0xfffff
    80004368:	184080e7          	jalr	388(ra) # 800034e8 <_Z11printStringPKc>
    8000436c:	00000613          	li	a2,0
    80004370:	00a00593          	li	a1,10
    80004374:	00048513          	mv	a0,s1
    80004378:	fffff097          	auipc	ra,0xfffff
    8000437c:	31c080e7          	jalr	796(ra) # 80003694 <_Z8printIntiii>
    80004380:	00005517          	auipc	a0,0x5
    80004384:	0f850513          	addi	a0,a0,248 # 80009478 <_ZTV8Consumer+0x1a0>
    80004388:	fffff097          	auipc	ra,0xfffff
    8000438c:	160080e7          	jalr	352(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004390:	0014849b          	addiw	s1,s1,1
    80004394:	0ff4f493          	andi	s1,s1,255
    80004398:	fbdff06f          	j	80004354 <_ZN7WorkerC11workerBodyCEPv+0xfc>
    }

    printString("A finished!\n");
    8000439c:	00005517          	auipc	a0,0x5
    800043a0:	e5c50513          	addi	a0,a0,-420 # 800091f8 <_ZTV12ConsumerSync+0x178>
    800043a4:	fffff097          	auipc	ra,0xfffff
    800043a8:	144080e7          	jalr	324(ra) # 800034e8 <_Z11printStringPKc>
    finishedC = true;
    800043ac:	00100793          	li	a5,1
    800043b0:	00007717          	auipc	a4,0x7
    800043b4:	24f70ca3          	sb	a5,601(a4) # 8000b609 <_ZL9finishedC>
    thread_dispatch();
    800043b8:	00002097          	auipc	ra,0x2
    800043bc:	9d0080e7          	jalr	-1584(ra) # 80005d88 <_Z15thread_dispatchv>
}
    800043c0:	01813083          	ld	ra,24(sp)
    800043c4:	01013403          	ld	s0,16(sp)
    800043c8:	00813483          	ld	s1,8(sp)
    800043cc:	00013903          	ld	s2,0(sp)
    800043d0:	02010113          	addi	sp,sp,32
    800043d4:	00008067          	ret

00000000800043d8 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    800043d8:	fe010113          	addi	sp,sp,-32
    800043dc:	00113c23          	sd	ra,24(sp)
    800043e0:	00813823          	sd	s0,16(sp)
    800043e4:	00913423          	sd	s1,8(sp)
    800043e8:	01213023          	sd	s2,0(sp)
    800043ec:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800043f0:	00a00493          	li	s1,10
    for (; i < 13; i++) {
    800043f4:	00c00793          	li	a5,12
    800043f8:	0497e263          	bltu	a5,s1,8000443c <_ZN7WorkerD11workerBodyDEPv+0x64>
        printString("D: i="); printInt(i); printString("\n");
    800043fc:	00005517          	auipc	a0,0x5
    80004400:	d9450513          	addi	a0,a0,-620 # 80009190 <_ZTV12ConsumerSync+0x110>
    80004404:	fffff097          	auipc	ra,0xfffff
    80004408:	0e4080e7          	jalr	228(ra) # 800034e8 <_Z11printStringPKc>
    8000440c:	00000613          	li	a2,0
    80004410:	00a00593          	li	a1,10
    80004414:	00048513          	mv	a0,s1
    80004418:	fffff097          	auipc	ra,0xfffff
    8000441c:	27c080e7          	jalr	636(ra) # 80003694 <_Z8printIntiii>
    80004420:	00005517          	auipc	a0,0x5
    80004424:	05850513          	addi	a0,a0,88 # 80009478 <_ZTV8Consumer+0x1a0>
    80004428:	fffff097          	auipc	ra,0xfffff
    8000442c:	0c0080e7          	jalr	192(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004430:	0014849b          	addiw	s1,s1,1
    80004434:	0ff4f493          	andi	s1,s1,255
    80004438:	fbdff06f          	j	800043f4 <_ZN7WorkerD11workerBodyDEPv+0x1c>
    }

    printString("D: dispatch\n");
    8000443c:	00005517          	auipc	a0,0x5
    80004440:	d5c50513          	addi	a0,a0,-676 # 80009198 <_ZTV12ConsumerSync+0x118>
    80004444:	fffff097          	auipc	ra,0xfffff
    80004448:	0a4080e7          	jalr	164(ra) # 800034e8 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000444c:	00500313          	li	t1,5
    thread_dispatch();
    80004450:	00002097          	auipc	ra,0x2
    80004454:	938080e7          	jalr	-1736(ra) # 80005d88 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004458:	01000513          	li	a0,16
    8000445c:	00000097          	auipc	ra,0x0
    80004460:	be4080e7          	jalr	-1052(ra) # 80004040 <_ZL9fibonaccim>
    80004464:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004468:	00005517          	auipc	a0,0x5
    8000446c:	d4050513          	addi	a0,a0,-704 # 800091a8 <_ZTV12ConsumerSync+0x128>
    80004470:	fffff097          	auipc	ra,0xfffff
    80004474:	078080e7          	jalr	120(ra) # 800034e8 <_Z11printStringPKc>
    80004478:	00000613          	li	a2,0
    8000447c:	00a00593          	li	a1,10
    80004480:	0009051b          	sext.w	a0,s2
    80004484:	fffff097          	auipc	ra,0xfffff
    80004488:	210080e7          	jalr	528(ra) # 80003694 <_Z8printIntiii>
    8000448c:	00005517          	auipc	a0,0x5
    80004490:	fec50513          	addi	a0,a0,-20 # 80009478 <_ZTV8Consumer+0x1a0>
    80004494:	fffff097          	auipc	ra,0xfffff
    80004498:	054080e7          	jalr	84(ra) # 800034e8 <_Z11printStringPKc>

    for (; i < 16; i++) {
    8000449c:	00f00793          	li	a5,15
    800044a0:	0497e263          	bltu	a5,s1,800044e4 <_ZN7WorkerD11workerBodyDEPv+0x10c>
        printString("D: i="); printInt(i); printString("\n");
    800044a4:	00005517          	auipc	a0,0x5
    800044a8:	cec50513          	addi	a0,a0,-788 # 80009190 <_ZTV12ConsumerSync+0x110>
    800044ac:	fffff097          	auipc	ra,0xfffff
    800044b0:	03c080e7          	jalr	60(ra) # 800034e8 <_Z11printStringPKc>
    800044b4:	00000613          	li	a2,0
    800044b8:	00a00593          	li	a1,10
    800044bc:	00048513          	mv	a0,s1
    800044c0:	fffff097          	auipc	ra,0xfffff
    800044c4:	1d4080e7          	jalr	468(ra) # 80003694 <_Z8printIntiii>
    800044c8:	00005517          	auipc	a0,0x5
    800044cc:	fb050513          	addi	a0,a0,-80 # 80009478 <_ZTV8Consumer+0x1a0>
    800044d0:	fffff097          	auipc	ra,0xfffff
    800044d4:	018080e7          	jalr	24(ra) # 800034e8 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800044d8:	0014849b          	addiw	s1,s1,1
    800044dc:	0ff4f493          	andi	s1,s1,255
    800044e0:	fbdff06f          	j	8000449c <_ZN7WorkerD11workerBodyDEPv+0xc4>
    }

    printString("D finished!\n");
    800044e4:	00005517          	auipc	a0,0x5
    800044e8:	cd450513          	addi	a0,a0,-812 # 800091b8 <_ZTV12ConsumerSync+0x138>
    800044ec:	fffff097          	auipc	ra,0xfffff
    800044f0:	ffc080e7          	jalr	-4(ra) # 800034e8 <_Z11printStringPKc>
    finishedD = true;
    800044f4:	00100793          	li	a5,1
    800044f8:	00007717          	auipc	a4,0x7
    800044fc:	10f70823          	sb	a5,272(a4) # 8000b608 <_ZL9finishedD>
    thread_dispatch();
    80004500:	00002097          	auipc	ra,0x2
    80004504:	888080e7          	jalr	-1912(ra) # 80005d88 <_Z15thread_dispatchv>
}
    80004508:	01813083          	ld	ra,24(sp)
    8000450c:	01013403          	ld	s0,16(sp)
    80004510:	00813483          	ld	s1,8(sp)
    80004514:	00013903          	ld	s2,0(sp)
    80004518:	02010113          	addi	sp,sp,32
    8000451c:	00008067          	ret

0000000080004520 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80004520:	fc010113          	addi	sp,sp,-64
    80004524:	02113c23          	sd	ra,56(sp)
    80004528:	02813823          	sd	s0,48(sp)
    8000452c:	02913423          	sd	s1,40(sp)
    80004530:	03213023          	sd	s2,32(sp)
    80004534:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80004538:	02000513          	li	a0,32
    8000453c:	00001097          	auipc	ra,0x1
    80004540:	3ac080e7          	jalr	940(ra) # 800058e8 <_Znwm>
    80004544:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80004548:	00000097          	auipc	ra,0x0
    8000454c:	6bc080e7          	jalr	1724(ra) # 80004c04 <_ZN6ThreadC1Ev>
    80004550:	00005797          	auipc	a5,0x5
    80004554:	05078793          	addi	a5,a5,80 # 800095a0 <_ZTV7WorkerA+0x10>
    80004558:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    8000455c:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80004560:	00005517          	auipc	a0,0x5
    80004564:	cc850513          	addi	a0,a0,-824 # 80009228 <_ZTV12ConsumerSync+0x1a8>
    80004568:	fffff097          	auipc	ra,0xfffff
    8000456c:	f80080e7          	jalr	-128(ra) # 800034e8 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80004570:	02000513          	li	a0,32
    80004574:	00001097          	auipc	ra,0x1
    80004578:	374080e7          	jalr	884(ra) # 800058e8 <_Znwm>
    8000457c:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80004580:	00000097          	auipc	ra,0x0
    80004584:	684080e7          	jalr	1668(ra) # 80004c04 <_ZN6ThreadC1Ev>
    80004588:	00005797          	auipc	a5,0x5
    8000458c:	04078793          	addi	a5,a5,64 # 800095c8 <_ZTV7WorkerB+0x10>
    80004590:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80004594:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80004598:	00005517          	auipc	a0,0x5
    8000459c:	ca850513          	addi	a0,a0,-856 # 80009240 <_ZTV12ConsumerSync+0x1c0>
    800045a0:	fffff097          	auipc	ra,0xfffff
    800045a4:	f48080e7          	jalr	-184(ra) # 800034e8 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    800045a8:	02000513          	li	a0,32
    800045ac:	00001097          	auipc	ra,0x1
    800045b0:	33c080e7          	jalr	828(ra) # 800058e8 <_Znwm>
    800045b4:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    800045b8:	00000097          	auipc	ra,0x0
    800045bc:	64c080e7          	jalr	1612(ra) # 80004c04 <_ZN6ThreadC1Ev>
    800045c0:	00005797          	auipc	a5,0x5
    800045c4:	03078793          	addi	a5,a5,48 # 800095f0 <_ZTV7WorkerC+0x10>
    800045c8:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    800045cc:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    800045d0:	00005517          	auipc	a0,0x5
    800045d4:	c8850513          	addi	a0,a0,-888 # 80009258 <_ZTV12ConsumerSync+0x1d8>
    800045d8:	fffff097          	auipc	ra,0xfffff
    800045dc:	f10080e7          	jalr	-240(ra) # 800034e8 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    800045e0:	02000513          	li	a0,32
    800045e4:	00001097          	auipc	ra,0x1
    800045e8:	304080e7          	jalr	772(ra) # 800058e8 <_Znwm>
    800045ec:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    800045f0:	00000097          	auipc	ra,0x0
    800045f4:	614080e7          	jalr	1556(ra) # 80004c04 <_ZN6ThreadC1Ev>
    800045f8:	00005797          	auipc	a5,0x5
    800045fc:	02078793          	addi	a5,a5,32 # 80009618 <_ZTV7WorkerD+0x10>
    80004600:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80004604:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80004608:	00005517          	auipc	a0,0x5
    8000460c:	c6850513          	addi	a0,a0,-920 # 80009270 <_ZTV12ConsumerSync+0x1f0>
    80004610:	fffff097          	auipc	ra,0xfffff
    80004614:	ed8080e7          	jalr	-296(ra) # 800034e8 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80004618:	00000493          	li	s1,0
    8000461c:	00300793          	li	a5,3
    80004620:	0297c663          	blt	a5,s1,8000464c <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80004624:	00349793          	slli	a5,s1,0x3
    80004628:	fe040713          	addi	a4,s0,-32
    8000462c:	00f707b3          	add	a5,a4,a5
    80004630:	fe07b503          	ld	a0,-32(a5)
    80004634:	00000097          	auipc	ra,0x0
    80004638:	560080e7          	jalr	1376(ra) # 80004b94 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    8000463c:	0014849b          	addiw	s1,s1,1
    80004640:	fddff06f          	j	8000461c <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80004644:	00000097          	auipc	ra,0x0
    80004648:	598080e7          	jalr	1432(ra) # 80004bdc <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    8000464c:	00007797          	auipc	a5,0x7
    80004650:	fbf78793          	addi	a5,a5,-65 # 8000b60b <_ZL9finishedA>
    80004654:	0007c783          	lbu	a5,0(a5)
    80004658:	0ff7f793          	andi	a5,a5,255
    8000465c:	fe0784e3          	beqz	a5,80004644 <_Z20Threads_CPP_API_testv+0x124>
    80004660:	00007797          	auipc	a5,0x7
    80004664:	faa78793          	addi	a5,a5,-86 # 8000b60a <_ZL9finishedB>
    80004668:	0007c783          	lbu	a5,0(a5)
    8000466c:	0ff7f793          	andi	a5,a5,255
    80004670:	fc078ae3          	beqz	a5,80004644 <_Z20Threads_CPP_API_testv+0x124>
    80004674:	00007797          	auipc	a5,0x7
    80004678:	f9578793          	addi	a5,a5,-107 # 8000b609 <_ZL9finishedC>
    8000467c:	0007c783          	lbu	a5,0(a5)
    80004680:	0ff7f793          	andi	a5,a5,255
    80004684:	fc0780e3          	beqz	a5,80004644 <_Z20Threads_CPP_API_testv+0x124>
    80004688:	00007797          	auipc	a5,0x7
    8000468c:	f8078793          	addi	a5,a5,-128 # 8000b608 <_ZL9finishedD>
    80004690:	0007c783          	lbu	a5,0(a5)
    80004694:	0ff7f793          	andi	a5,a5,255
    80004698:	fa0786e3          	beqz	a5,80004644 <_Z20Threads_CPP_API_testv+0x124>
    }

    for (auto thread: threads) { delete thread; }
    8000469c:	fc040493          	addi	s1,s0,-64
    800046a0:	0080006f          	j	800046a8 <_Z20Threads_CPP_API_testv+0x188>
    800046a4:	00848493          	addi	s1,s1,8
    800046a8:	fe040793          	addi	a5,s0,-32
    800046ac:	08f48663          	beq	s1,a5,80004738 <_Z20Threads_CPP_API_testv+0x218>
    800046b0:	0004b503          	ld	a0,0(s1)
    800046b4:	fe0508e3          	beqz	a0,800046a4 <_Z20Threads_CPP_API_testv+0x184>
    800046b8:	00053783          	ld	a5,0(a0)
    800046bc:	0087b783          	ld	a5,8(a5)
    800046c0:	000780e7          	jalr	a5
    800046c4:	fe1ff06f          	j	800046a4 <_Z20Threads_CPP_API_testv+0x184>
    800046c8:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    800046cc:	00048513          	mv	a0,s1
    800046d0:	00001097          	auipc	ra,0x1
    800046d4:	268080e7          	jalr	616(ra) # 80005938 <_ZdlPv>
    800046d8:	00090513          	mv	a0,s2
    800046dc:	00008097          	auipc	ra,0x8
    800046e0:	09c080e7          	jalr	156(ra) # 8000c778 <_Unwind_Resume>
    800046e4:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    800046e8:	00048513          	mv	a0,s1
    800046ec:	00001097          	auipc	ra,0x1
    800046f0:	24c080e7          	jalr	588(ra) # 80005938 <_ZdlPv>
    800046f4:	00090513          	mv	a0,s2
    800046f8:	00008097          	auipc	ra,0x8
    800046fc:	080080e7          	jalr	128(ra) # 8000c778 <_Unwind_Resume>
    80004700:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80004704:	00048513          	mv	a0,s1
    80004708:	00001097          	auipc	ra,0x1
    8000470c:	230080e7          	jalr	560(ra) # 80005938 <_ZdlPv>
    80004710:	00090513          	mv	a0,s2
    80004714:	00008097          	auipc	ra,0x8
    80004718:	064080e7          	jalr	100(ra) # 8000c778 <_Unwind_Resume>
    8000471c:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80004720:	00048513          	mv	a0,s1
    80004724:	00001097          	auipc	ra,0x1
    80004728:	214080e7          	jalr	532(ra) # 80005938 <_ZdlPv>
    8000472c:	00090513          	mv	a0,s2
    80004730:	00008097          	auipc	ra,0x8
    80004734:	048080e7          	jalr	72(ra) # 8000c778 <_Unwind_Resume>
}
    80004738:	03813083          	ld	ra,56(sp)
    8000473c:	03013403          	ld	s0,48(sp)
    80004740:	02813483          	ld	s1,40(sp)
    80004744:	02013903          	ld	s2,32(sp)
    80004748:	04010113          	addi	sp,sp,64
    8000474c:	00008067          	ret

0000000080004750 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80004750:	ff010113          	addi	sp,sp,-16
    80004754:	00113423          	sd	ra,8(sp)
    80004758:	00813023          	sd	s0,0(sp)
    8000475c:	01010413          	addi	s0,sp,16
    80004760:	00005797          	auipc	a5,0x5
    80004764:	e4078793          	addi	a5,a5,-448 # 800095a0 <_ZTV7WorkerA+0x10>
    80004768:	00f53023          	sd	a5,0(a0)
    8000476c:	00000097          	auipc	ra,0x0
    80004770:	294080e7          	jalr	660(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80004774:	00813083          	ld	ra,8(sp)
    80004778:	00013403          	ld	s0,0(sp)
    8000477c:	01010113          	addi	sp,sp,16
    80004780:	00008067          	ret

0000000080004784 <_ZN7WorkerAD0Ev>:
    80004784:	fe010113          	addi	sp,sp,-32
    80004788:	00113c23          	sd	ra,24(sp)
    8000478c:	00813823          	sd	s0,16(sp)
    80004790:	00913423          	sd	s1,8(sp)
    80004794:	02010413          	addi	s0,sp,32
    80004798:	00050493          	mv	s1,a0
    8000479c:	00005797          	auipc	a5,0x5
    800047a0:	e0478793          	addi	a5,a5,-508 # 800095a0 <_ZTV7WorkerA+0x10>
    800047a4:	00f53023          	sd	a5,0(a0)
    800047a8:	00000097          	auipc	ra,0x0
    800047ac:	258080e7          	jalr	600(ra) # 80004a00 <_ZN6ThreadD1Ev>
    800047b0:	00048513          	mv	a0,s1
    800047b4:	00001097          	auipc	ra,0x1
    800047b8:	184080e7          	jalr	388(ra) # 80005938 <_ZdlPv>
    800047bc:	01813083          	ld	ra,24(sp)
    800047c0:	01013403          	ld	s0,16(sp)
    800047c4:	00813483          	ld	s1,8(sp)
    800047c8:	02010113          	addi	sp,sp,32
    800047cc:	00008067          	ret

00000000800047d0 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    800047d0:	ff010113          	addi	sp,sp,-16
    800047d4:	00113423          	sd	ra,8(sp)
    800047d8:	00813023          	sd	s0,0(sp)
    800047dc:	01010413          	addi	s0,sp,16
    800047e0:	00005797          	auipc	a5,0x5
    800047e4:	de878793          	addi	a5,a5,-536 # 800095c8 <_ZTV7WorkerB+0x10>
    800047e8:	00f53023          	sd	a5,0(a0)
    800047ec:	00000097          	auipc	ra,0x0
    800047f0:	214080e7          	jalr	532(ra) # 80004a00 <_ZN6ThreadD1Ev>
    800047f4:	00813083          	ld	ra,8(sp)
    800047f8:	00013403          	ld	s0,0(sp)
    800047fc:	01010113          	addi	sp,sp,16
    80004800:	00008067          	ret

0000000080004804 <_ZN7WorkerBD0Ev>:
    80004804:	fe010113          	addi	sp,sp,-32
    80004808:	00113c23          	sd	ra,24(sp)
    8000480c:	00813823          	sd	s0,16(sp)
    80004810:	00913423          	sd	s1,8(sp)
    80004814:	02010413          	addi	s0,sp,32
    80004818:	00050493          	mv	s1,a0
    8000481c:	00005797          	auipc	a5,0x5
    80004820:	dac78793          	addi	a5,a5,-596 # 800095c8 <_ZTV7WorkerB+0x10>
    80004824:	00f53023          	sd	a5,0(a0)
    80004828:	00000097          	auipc	ra,0x0
    8000482c:	1d8080e7          	jalr	472(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80004830:	00048513          	mv	a0,s1
    80004834:	00001097          	auipc	ra,0x1
    80004838:	104080e7          	jalr	260(ra) # 80005938 <_ZdlPv>
    8000483c:	01813083          	ld	ra,24(sp)
    80004840:	01013403          	ld	s0,16(sp)
    80004844:	00813483          	ld	s1,8(sp)
    80004848:	02010113          	addi	sp,sp,32
    8000484c:	00008067          	ret

0000000080004850 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80004850:	ff010113          	addi	sp,sp,-16
    80004854:	00113423          	sd	ra,8(sp)
    80004858:	00813023          	sd	s0,0(sp)
    8000485c:	01010413          	addi	s0,sp,16
    80004860:	00005797          	auipc	a5,0x5
    80004864:	d9078793          	addi	a5,a5,-624 # 800095f0 <_ZTV7WorkerC+0x10>
    80004868:	00f53023          	sd	a5,0(a0)
    8000486c:	00000097          	auipc	ra,0x0
    80004870:	194080e7          	jalr	404(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80004874:	00813083          	ld	ra,8(sp)
    80004878:	00013403          	ld	s0,0(sp)
    8000487c:	01010113          	addi	sp,sp,16
    80004880:	00008067          	ret

0000000080004884 <_ZN7WorkerCD0Ev>:
    80004884:	fe010113          	addi	sp,sp,-32
    80004888:	00113c23          	sd	ra,24(sp)
    8000488c:	00813823          	sd	s0,16(sp)
    80004890:	00913423          	sd	s1,8(sp)
    80004894:	02010413          	addi	s0,sp,32
    80004898:	00050493          	mv	s1,a0
    8000489c:	00005797          	auipc	a5,0x5
    800048a0:	d5478793          	addi	a5,a5,-684 # 800095f0 <_ZTV7WorkerC+0x10>
    800048a4:	00f53023          	sd	a5,0(a0)
    800048a8:	00000097          	auipc	ra,0x0
    800048ac:	158080e7          	jalr	344(ra) # 80004a00 <_ZN6ThreadD1Ev>
    800048b0:	00048513          	mv	a0,s1
    800048b4:	00001097          	auipc	ra,0x1
    800048b8:	084080e7          	jalr	132(ra) # 80005938 <_ZdlPv>
    800048bc:	01813083          	ld	ra,24(sp)
    800048c0:	01013403          	ld	s0,16(sp)
    800048c4:	00813483          	ld	s1,8(sp)
    800048c8:	02010113          	addi	sp,sp,32
    800048cc:	00008067          	ret

00000000800048d0 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    800048d0:	ff010113          	addi	sp,sp,-16
    800048d4:	00113423          	sd	ra,8(sp)
    800048d8:	00813023          	sd	s0,0(sp)
    800048dc:	01010413          	addi	s0,sp,16
    800048e0:	00005797          	auipc	a5,0x5
    800048e4:	d3878793          	addi	a5,a5,-712 # 80009618 <_ZTV7WorkerD+0x10>
    800048e8:	00f53023          	sd	a5,0(a0)
    800048ec:	00000097          	auipc	ra,0x0
    800048f0:	114080e7          	jalr	276(ra) # 80004a00 <_ZN6ThreadD1Ev>
    800048f4:	00813083          	ld	ra,8(sp)
    800048f8:	00013403          	ld	s0,0(sp)
    800048fc:	01010113          	addi	sp,sp,16
    80004900:	00008067          	ret

0000000080004904 <_ZN7WorkerDD0Ev>:
    80004904:	fe010113          	addi	sp,sp,-32
    80004908:	00113c23          	sd	ra,24(sp)
    8000490c:	00813823          	sd	s0,16(sp)
    80004910:	00913423          	sd	s1,8(sp)
    80004914:	02010413          	addi	s0,sp,32
    80004918:	00050493          	mv	s1,a0
    8000491c:	00005797          	auipc	a5,0x5
    80004920:	cfc78793          	addi	a5,a5,-772 # 80009618 <_ZTV7WorkerD+0x10>
    80004924:	00f53023          	sd	a5,0(a0)
    80004928:	00000097          	auipc	ra,0x0
    8000492c:	0d8080e7          	jalr	216(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80004930:	00048513          	mv	a0,s1
    80004934:	00001097          	auipc	ra,0x1
    80004938:	004080e7          	jalr	4(ra) # 80005938 <_ZdlPv>
    8000493c:	01813083          	ld	ra,24(sp)
    80004940:	01013403          	ld	s0,16(sp)
    80004944:	00813483          	ld	s1,8(sp)
    80004948:	02010113          	addi	sp,sp,32
    8000494c:	00008067          	ret

0000000080004950 <_ZN7WorkerA3runEv>:
    void run() override {
    80004950:	ff010113          	addi	sp,sp,-16
    80004954:	00113423          	sd	ra,8(sp)
    80004958:	00813023          	sd	s0,0(sp)
    8000495c:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80004960:	00000593          	li	a1,0
    80004964:	fffff097          	auipc	ra,0xfffff
    80004968:	754080e7          	jalr	1876(ra) # 800040b8 <_ZN7WorkerA11workerBodyAEPv>
    }
    8000496c:	00813083          	ld	ra,8(sp)
    80004970:	00013403          	ld	s0,0(sp)
    80004974:	01010113          	addi	sp,sp,16
    80004978:	00008067          	ret

000000008000497c <_ZN7WorkerB3runEv>:
    void run() override {
    8000497c:	ff010113          	addi	sp,sp,-16
    80004980:	00113423          	sd	ra,8(sp)
    80004984:	00813023          	sd	s0,0(sp)
    80004988:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    8000498c:	00000593          	li	a1,0
    80004990:	fffff097          	auipc	ra,0xfffff
    80004994:	7f4080e7          	jalr	2036(ra) # 80004184 <_ZN7WorkerB11workerBodyBEPv>
    }
    80004998:	00813083          	ld	ra,8(sp)
    8000499c:	00013403          	ld	s0,0(sp)
    800049a0:	01010113          	addi	sp,sp,16
    800049a4:	00008067          	ret

00000000800049a8 <_ZN7WorkerC3runEv>:
    void run() override {
    800049a8:	ff010113          	addi	sp,sp,-16
    800049ac:	00113423          	sd	ra,8(sp)
    800049b0:	00813023          	sd	s0,0(sp)
    800049b4:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    800049b8:	00000593          	li	a1,0
    800049bc:	00000097          	auipc	ra,0x0
    800049c0:	89c080e7          	jalr	-1892(ra) # 80004258 <_ZN7WorkerC11workerBodyCEPv>
    }
    800049c4:	00813083          	ld	ra,8(sp)
    800049c8:	00013403          	ld	s0,0(sp)
    800049cc:	01010113          	addi	sp,sp,16
    800049d0:	00008067          	ret

00000000800049d4 <_ZN7WorkerD3runEv>:
    void run() override {
    800049d4:	ff010113          	addi	sp,sp,-16
    800049d8:	00113423          	sd	ra,8(sp)
    800049dc:	00813023          	sd	s0,0(sp)
    800049e0:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800049e4:	00000593          	li	a1,0
    800049e8:	00000097          	auipc	ra,0x0
    800049ec:	9f0080e7          	jalr	-1552(ra) # 800043d8 <_ZN7WorkerD11workerBodyDEPv>
    }
    800049f0:	00813083          	ld	ra,8(sp)
    800049f4:	00013403          	ld	s0,0(sp)
    800049f8:	01010113          	addi	sp,sp,16
    800049fc:	00008067          	ret

0000000080004a00 <_ZN6ThreadD1Ev>:

void Thread::dispatch() {
    thread_dispatch();
}

Thread::~Thread() {
    80004a00:	fe010113          	addi	sp,sp,-32
    80004a04:	00113c23          	sd	ra,24(sp)
    80004a08:	00813823          	sd	s0,16(sp)
    80004a0c:	00913423          	sd	s1,8(sp)
    80004a10:	02010413          	addi	s0,sp,32
    80004a14:	00005797          	auipc	a5,0x5
    80004a18:	c2c78793          	addi	a5,a5,-980 # 80009640 <_ZTV6Thread+0x10>
    80004a1c:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80004a20:	00853483          	ld	s1,8(a0)
    80004a24:	02048063          	beqz	s1,80004a44 <_ZN6ThreadD1Ev+0x44>
    void *operator new[](size_t n) { return MemoryAllocator::mem_alloc((n + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE); }

    void operator delete(void *p) noexcept { MemoryAllocator::mem_free(p); }
    void operator delete[](void *p) noexcept { MemoryAllocator::mem_free(p); }

    ~TCB() { delete[] stack; }
    80004a28:	0104b503          	ld	a0,16(s1)
    80004a2c:	00050663          	beqz	a0,80004a38 <_ZN6ThreadD1Ev+0x38>
    80004a30:	00001097          	auipc	ra,0x1
    80004a34:	f30080e7          	jalr	-208(ra) # 80005960 <_ZdaPv>
    void operator delete(void *p) noexcept { MemoryAllocator::mem_free(p); }
    80004a38:	00048513          	mv	a0,s1
    80004a3c:	00001097          	auipc	ra,0x1
    80004a40:	10c080e7          	jalr	268(ra) # 80005b48 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80004a44:	01813083          	ld	ra,24(sp)
    80004a48:	01013403          	ld	s0,16(sp)
    80004a4c:	00813483          	ld	s1,8(sp)
    80004a50:	02010113          	addi	sp,sp,32
    80004a54:	00008067          	ret

0000000080004a58 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80004a58:	fe010113          	addi	sp,sp,-32
    80004a5c:	00113c23          	sd	ra,24(sp)
    80004a60:	00813823          	sd	s0,16(sp)
    80004a64:	00913423          	sd	s1,8(sp)
    80004a68:	02010413          	addi	s0,sp,32
    80004a6c:	00050493          	mv	s1,a0
}
    80004a70:	00000097          	auipc	ra,0x0
    80004a74:	f90080e7          	jalr	-112(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80004a78:	00048513          	mv	a0,s1
    80004a7c:	00001097          	auipc	ra,0x1
    80004a80:	ebc080e7          	jalr	-324(ra) # 80005938 <_ZdlPv>
    80004a84:	01813083          	ld	ra,24(sp)
    80004a88:	01013403          	ld	s0,16(sp)
    80004a8c:	00813483          	ld	s1,8(sp)
    80004a90:	02010113          	addi	sp,sp,32
    80004a94:	00008067          	ret

0000000080004a98 <_ZN14PeriodicThread3runEv>:

PeriodicThread::PeriodicThread(time_t period) {
    this->period = period;
}

void PeriodicThread::run() {
    80004a98:	fe010113          	addi	sp,sp,-32
    80004a9c:	00113c23          	sd	ra,24(sp)
    80004aa0:	00813823          	sd	s0,16(sp)
    80004aa4:	00913423          	sd	s1,8(sp)
    80004aa8:	02010413          	addi	s0,sp,32
    80004aac:	00050493          	mv	s1,a0
    while(period) {
    80004ab0:	0204b783          	ld	a5,32(s1)
    80004ab4:	02078263          	beqz	a5,80004ad8 <_ZN14PeriodicThread3runEv+0x40>
        periodicActivation();
    80004ab8:	0004b783          	ld	a5,0(s1)
    80004abc:	0187b783          	ld	a5,24(a5)
    80004ac0:	00048513          	mv	a0,s1
    80004ac4:	000780e7          	jalr	a5
        time_sleep(period);
    80004ac8:	0204b503          	ld	a0,32(s1)
    80004acc:	00001097          	auipc	ra,0x1
    80004ad0:	2e0080e7          	jalr	736(ra) # 80005dac <_Z10time_sleepm>
    while(period) {
    80004ad4:	fddff06f          	j	80004ab0 <_ZN14PeriodicThread3runEv+0x18>
    }
}
    80004ad8:	01813083          	ld	ra,24(sp)
    80004adc:	01013403          	ld	s0,16(sp)
    80004ae0:	00813483          	ld	s1,8(sp)
    80004ae4:	02010113          	addi	sp,sp,32
    80004ae8:	00008067          	ret

0000000080004aec <_ZN9SemaphoreD1Ev>:
Semaphore::Semaphore(unsigned int init) {
    myHandle = nullptr;
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    80004aec:	ff010113          	addi	sp,sp,-16
    80004af0:	00113423          	sd	ra,8(sp)
    80004af4:	00813023          	sd	s0,0(sp)
    80004af8:	01010413          	addi	s0,sp,16
    80004afc:	00005797          	auipc	a5,0x5
    80004b00:	b9c78793          	addi	a5,a5,-1124 # 80009698 <_ZTV9Semaphore+0x10>
    80004b04:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80004b08:	00853503          	ld	a0,8(a0)
    80004b0c:	00001097          	auipc	ra,0x1
    80004b10:	308080e7          	jalr	776(ra) # 80005e14 <_Z9sem_closeP5mySem>
}
    80004b14:	00813083          	ld	ra,8(sp)
    80004b18:	00013403          	ld	s0,0(sp)
    80004b1c:	01010113          	addi	sp,sp,16
    80004b20:	00008067          	ret

0000000080004b24 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80004b24:	fe010113          	addi	sp,sp,-32
    80004b28:	00113c23          	sd	ra,24(sp)
    80004b2c:	00813823          	sd	s0,16(sp)
    80004b30:	00913423          	sd	s1,8(sp)
    80004b34:	02010413          	addi	s0,sp,32
    80004b38:	00050493          	mv	s1,a0
}
    80004b3c:	00000097          	auipc	ra,0x0
    80004b40:	fb0080e7          	jalr	-80(ra) # 80004aec <_ZN9SemaphoreD1Ev>
    80004b44:	00048513          	mv	a0,s1
    80004b48:	00001097          	auipc	ra,0x1
    80004b4c:	df0080e7          	jalr	-528(ra) # 80005938 <_ZdlPv>
    80004b50:	01813083          	ld	ra,24(sp)
    80004b54:	01013403          	ld	s0,16(sp)
    80004b58:	00813483          	ld	s1,8(sp)
    80004b5c:	02010113          	addi	sp,sp,32
    80004b60:	00008067          	ret

0000000080004b64 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void* arg) {
    80004b64:	ff010113          	addi	sp,sp,-16
    80004b68:	00813423          	sd	s0,8(sp)
    80004b6c:	01010413          	addi	s0,sp,16
    80004b70:	00005797          	auipc	a5,0x5
    80004b74:	ad078793          	addi	a5,a5,-1328 # 80009640 <_ZTV6Thread+0x10>
    80004b78:	00f53023          	sd	a5,0(a0)
    myHandle = nullptr;
    80004b7c:	00053423          	sd	zero,8(a0)
    this->body = body;
    80004b80:	00b53823          	sd	a1,16(a0)
    this->arg = arg;
    80004b84:	00c53c23          	sd	a2,24(a0)
}
    80004b88:	00813403          	ld	s0,8(sp)
    80004b8c:	01010113          	addi	sp,sp,16
    80004b90:	00008067          	ret

0000000080004b94 <_ZN6Thread5startEv>:
    if(myHandle != nullptr)
    80004b94:	00853783          	ld	a5,8(a0)
    80004b98:	02079e63          	bnez	a5,80004bd4 <_ZN6Thread5startEv+0x40>
int Thread::start() {
    80004b9c:	ff010113          	addi	sp,sp,-16
    80004ba0:	00113423          	sd	ra,8(sp)
    80004ba4:	00813023          	sd	s0,0(sp)
    80004ba8:	01010413          	addi	s0,sp,16
    return thread_create(&myHandle, runWrapper, this);
    80004bac:	00050613          	mv	a2,a0
    80004bb0:	00000597          	auipc	a1,0x0
    80004bb4:	27058593          	addi	a1,a1,624 # 80004e20 <_ZN6Thread10runWrapperEPv>
    80004bb8:	00850513          	addi	a0,a0,8
    80004bbc:	00001097          	auipc	ra,0x1
    80004bc0:	11c080e7          	jalr	284(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
}
    80004bc4:	00813083          	ld	ra,8(sp)
    80004bc8:	00013403          	ld	s0,0(sp)
    80004bcc:	01010113          	addi	sp,sp,16
    80004bd0:	00008067          	ret
        return -1;
    80004bd4:	fff00513          	li	a0,-1
}
    80004bd8:	00008067          	ret

0000000080004bdc <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80004bdc:	ff010113          	addi	sp,sp,-16
    80004be0:	00113423          	sd	ra,8(sp)
    80004be4:	00813023          	sd	s0,0(sp)
    80004be8:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80004bec:	00001097          	auipc	ra,0x1
    80004bf0:	19c080e7          	jalr	412(ra) # 80005d88 <_Z15thread_dispatchv>
}
    80004bf4:	00813083          	ld	ra,8(sp)
    80004bf8:	00013403          	ld	s0,0(sp)
    80004bfc:	01010113          	addi	sp,sp,16
    80004c00:	00008067          	ret

0000000080004c04 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80004c04:	ff010113          	addi	sp,sp,-16
    80004c08:	00813423          	sd	s0,8(sp)
    80004c0c:	01010413          	addi	s0,sp,16
    80004c10:	00005797          	auipc	a5,0x5
    80004c14:	a3078793          	addi	a5,a5,-1488 # 80009640 <_ZTV6Thread+0x10>
    80004c18:	00f53023          	sd	a5,0(a0)
    myHandle = nullptr;
    80004c1c:	00053423          	sd	zero,8(a0)
    arg = nullptr;
    80004c20:	00053c23          	sd	zero,24(a0)
    body = nullptr;
    80004c24:	00053823          	sd	zero,16(a0)
}
    80004c28:	00813403          	ld	s0,8(sp)
    80004c2c:	01010113          	addi	sp,sp,16
    80004c30:	00008067          	ret

0000000080004c34 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80004c34:	ff010113          	addi	sp,sp,-16
    80004c38:	00113423          	sd	ra,8(sp)
    80004c3c:	00813023          	sd	s0,0(sp)
    80004c40:	01010413          	addi	s0,sp,16
    time_sleep(time);
    80004c44:	00001097          	auipc	ra,0x1
    80004c48:	168080e7          	jalr	360(ra) # 80005dac <_Z10time_sleepm>
}
    80004c4c:	00000513          	li	a0,0
    80004c50:	00813083          	ld	ra,8(sp)
    80004c54:	00013403          	ld	s0,0(sp)
    80004c58:	01010113          	addi	sp,sp,16
    80004c5c:	00008067          	ret

0000000080004c60 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) {
    80004c60:	fe010113          	addi	sp,sp,-32
    80004c64:	00113c23          	sd	ra,24(sp)
    80004c68:	00813823          	sd	s0,16(sp)
    80004c6c:	00913423          	sd	s1,8(sp)
    80004c70:	01213023          	sd	s2,0(sp)
    80004c74:	02010413          	addi	s0,sp,32
    80004c78:	00050493          	mv	s1,a0
    80004c7c:	00058913          	mv	s2,a1
    80004c80:	00000097          	auipc	ra,0x0
    80004c84:	f84080e7          	jalr	-124(ra) # 80004c04 <_ZN6ThreadC1Ev>
    80004c88:	00005797          	auipc	a5,0x5
    80004c8c:	9e078793          	addi	a5,a5,-1568 # 80009668 <_ZTV14PeriodicThread+0x10>
    80004c90:	00f4b023          	sd	a5,0(s1)
    this->period = period;
    80004c94:	0324b023          	sd	s2,32(s1)
}
    80004c98:	01813083          	ld	ra,24(sp)
    80004c9c:	01013403          	ld	s0,16(sp)
    80004ca0:	00813483          	ld	s1,8(sp)
    80004ca4:	00013903          	ld	s2,0(sp)
    80004ca8:	02010113          	addi	sp,sp,32
    80004cac:	00008067          	ret

0000000080004cb0 <_ZN14PeriodicThread9terminateEv>:
void PeriodicThread::terminate() {
    80004cb0:	ff010113          	addi	sp,sp,-16
    80004cb4:	00813423          	sd	s0,8(sp)
    80004cb8:	01010413          	addi	s0,sp,16
    period = 0;
    80004cbc:	02053023          	sd	zero,32(a0)
}
    80004cc0:	00813403          	ld	s0,8(sp)
    80004cc4:	01010113          	addi	sp,sp,16
    80004cc8:	00008067          	ret

0000000080004ccc <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80004ccc:	ff010113          	addi	sp,sp,-16
    80004cd0:	00113423          	sd	ra,8(sp)
    80004cd4:	00813023          	sd	s0,0(sp)
    80004cd8:	01010413          	addi	s0,sp,16
    80004cdc:	00005797          	auipc	a5,0x5
    80004ce0:	9bc78793          	addi	a5,a5,-1604 # 80009698 <_ZTV9Semaphore+0x10>
    80004ce4:	00f53023          	sd	a5,0(a0)
    myHandle = nullptr;
    80004ce8:	00053423          	sd	zero,8(a0)
    sem_open(&myHandle, init);
    80004cec:	00850513          	addi	a0,a0,8
    80004cf0:	00001097          	auipc	ra,0x1
    80004cf4:	0e8080e7          	jalr	232(ra) # 80005dd8 <_Z8sem_openPP5mySemj>
}
    80004cf8:	00813083          	ld	ra,8(sp)
    80004cfc:	00013403          	ld	s0,0(sp)
    80004d00:	01010113          	addi	sp,sp,16
    80004d04:	00008067          	ret

0000000080004d08 <_ZN9Semaphore6signalEv>:

int Semaphore::signal() {
    80004d08:	ff010113          	addi	sp,sp,-16
    80004d0c:	00113423          	sd	ra,8(sp)
    80004d10:	00813023          	sd	s0,0(sp)
    80004d14:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80004d18:	00853503          	ld	a0,8(a0)
    80004d1c:	00001097          	auipc	ra,0x1
    80004d20:	168080e7          	jalr	360(ra) # 80005e84 <_Z10sem_signalP5mySem>
}
    80004d24:	00813083          	ld	ra,8(sp)
    80004d28:	00013403          	ld	s0,0(sp)
    80004d2c:	01010113          	addi	sp,sp,16
    80004d30:	00008067          	ret

0000000080004d34 <_ZN9Semaphore4waitEv>:

int Semaphore::wait() {
    80004d34:	ff010113          	addi	sp,sp,-16
    80004d38:	00113423          	sd	ra,8(sp)
    80004d3c:	00813023          	sd	s0,0(sp)
    80004d40:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80004d44:	00853503          	ld	a0,8(a0)
    80004d48:	00001097          	auipc	ra,0x1
    80004d4c:	104080e7          	jalr	260(ra) # 80005e4c <_Z8sem_waitP5mySem>
}
    80004d50:	00813083          	ld	ra,8(sp)
    80004d54:	00013403          	ld	s0,0(sp)
    80004d58:	01010113          	addi	sp,sp,16
    80004d5c:	00008067          	ret

0000000080004d60 <_ZN9Semaphore7tryWaitEv>:

int Semaphore::tryWait() {
    80004d60:	ff010113          	addi	sp,sp,-16
    80004d64:	00113423          	sd	ra,8(sp)
    80004d68:	00813023          	sd	s0,0(sp)
    80004d6c:	01010413          	addi	s0,sp,16
    return sem_trywait(myHandle);
    80004d70:	00853503          	ld	a0,8(a0)
    80004d74:	00001097          	auipc	ra,0x1
    80004d78:	148080e7          	jalr	328(ra) # 80005ebc <_Z11sem_trywaitP5mySem>
}
    80004d7c:	00813083          	ld	ra,8(sp)
    80004d80:	00013403          	ld	s0,0(sp)
    80004d84:	01010113          	addi	sp,sp,16
    80004d88:	00008067          	ret

0000000080004d8c <_ZN9Semaphore9timedWaitEm>:

int Semaphore::timedWait(time_t time) {
    80004d8c:	ff010113          	addi	sp,sp,-16
    80004d90:	00113423          	sd	ra,8(sp)
    80004d94:	00813023          	sd	s0,0(sp)
    80004d98:	01010413          	addi	s0,sp,16
    return sem_timedwait(myHandle, time);
    80004d9c:	00853503          	ld	a0,8(a0)
    80004da0:	00001097          	auipc	ra,0x1
    80004da4:	154080e7          	jalr	340(ra) # 80005ef4 <_Z13sem_timedwaitP5mySemm>
}
    80004da8:	00813083          	ld	ra,8(sp)
    80004dac:	00013403          	ld	s0,0(sp)
    80004db0:	01010113          	addi	sp,sp,16
    80004db4:	00008067          	ret

0000000080004db8 <_ZN7Console4getcEv>:


char Console::getc() {
    80004db8:	ff010113          	addi	sp,sp,-16
    80004dbc:	00113423          	sd	ra,8(sp)
    80004dc0:	00813023          	sd	s0,0(sp)
    80004dc4:	01010413          	addi	s0,sp,16
    return ::getc();
    80004dc8:	00001097          	auipc	ra,0x1
    80004dcc:	168080e7          	jalr	360(ra) # 80005f30 <_Z4getcv>
}
    80004dd0:	00813083          	ld	ra,8(sp)
    80004dd4:	00013403          	ld	s0,0(sp)
    80004dd8:	01010113          	addi	sp,sp,16
    80004ddc:	00008067          	ret

0000000080004de0 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80004de0:	ff010113          	addi	sp,sp,-16
    80004de4:	00113423          	sd	ra,8(sp)
    80004de8:	00813023          	sd	s0,0(sp)
    80004dec:	01010413          	addi	s0,sp,16
    return ::putc(c);
    80004df0:	00001097          	auipc	ra,0x1
    80004df4:	170080e7          	jalr	368(ra) # 80005f60 <_Z4putcc>
}
    80004df8:	00813083          	ld	ra,8(sp)
    80004dfc:	00013403          	ld	s0,0(sp)
    80004e00:	01010113          	addi	sp,sp,16
    80004e04:	00008067          	ret

0000000080004e08 <_ZN6Thread3runEv>:

    static void dispatch ();
    static int sleep(time_t);
protected:
    Thread();
    virtual void run () {}
    80004e08:	ff010113          	addi	sp,sp,-16
    80004e0c:	00813423          	sd	s0,8(sp)
    80004e10:	01010413          	addi	s0,sp,16
    80004e14:	00813403          	ld	s0,8(sp)
    80004e18:	01010113          	addi	sp,sp,16
    80004e1c:	00008067          	ret

0000000080004e20 <_ZN6Thread10runWrapperEPv>:
    thread_t myHandle;
    void (*body)(void*);
    void* arg;

    static void runWrapper(void* thread) {
        if(thread != nullptr) {
    80004e20:	02050863          	beqz	a0,80004e50 <_ZN6Thread10runWrapperEPv+0x30>
    static void runWrapper(void* thread) {
    80004e24:	ff010113          	addi	sp,sp,-16
    80004e28:	00113423          	sd	ra,8(sp)
    80004e2c:	00813023          	sd	s0,0(sp)
    80004e30:	01010413          	addi	s0,sp,16
            ((Thread*)thread)->run();
    80004e34:	00053783          	ld	a5,0(a0)
    80004e38:	0107b783          	ld	a5,16(a5)
    80004e3c:	000780e7          	jalr	a5
        }
    }
    80004e40:	00813083          	ld	ra,8(sp)
    80004e44:	00013403          	ld	s0,0(sp)
    80004e48:	01010113          	addi	sp,sp,16
    80004e4c:	00008067          	ret
    80004e50:	00008067          	ret

0000000080004e54 <_ZN14PeriodicThread18periodicActivationEv>:
class PeriodicThread : public Thread {
public:
    void terminate();
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation() {}
    80004e54:	ff010113          	addi	sp,sp,-16
    80004e58:	00813423          	sd	s0,8(sp)
    80004e5c:	01010413          	addi	s0,sp,16
    80004e60:	00813403          	ld	s0,8(sp)
    80004e64:	01010113          	addi	sp,sp,16
    80004e68:	00008067          	ret

0000000080004e6c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    80004e6c:	ff010113          	addi	sp,sp,-16
    80004e70:	00113423          	sd	ra,8(sp)
    80004e74:	00813023          	sd	s0,0(sp)
    80004e78:	01010413          	addi	s0,sp,16
    80004e7c:	00004797          	auipc	a5,0x4
    80004e80:	7ec78793          	addi	a5,a5,2028 # 80009668 <_ZTV14PeriodicThread+0x10>
    80004e84:	00f53023          	sd	a5,0(a0)
    80004e88:	00000097          	auipc	ra,0x0
    80004e8c:	b78080e7          	jalr	-1160(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80004e90:	00813083          	ld	ra,8(sp)
    80004e94:	00013403          	ld	s0,0(sp)
    80004e98:	01010113          	addi	sp,sp,16
    80004e9c:	00008067          	ret

0000000080004ea0 <_ZN14PeriodicThreadD0Ev>:
    80004ea0:	fe010113          	addi	sp,sp,-32
    80004ea4:	00113c23          	sd	ra,24(sp)
    80004ea8:	00813823          	sd	s0,16(sp)
    80004eac:	00913423          	sd	s1,8(sp)
    80004eb0:	02010413          	addi	s0,sp,32
    80004eb4:	00050493          	mv	s1,a0
    80004eb8:	00004797          	auipc	a5,0x4
    80004ebc:	7b078793          	addi	a5,a5,1968 # 80009668 <_ZTV14PeriodicThread+0x10>
    80004ec0:	00f53023          	sd	a5,0(a0)
    80004ec4:	00000097          	auipc	ra,0x0
    80004ec8:	b3c080e7          	jalr	-1220(ra) # 80004a00 <_ZN6ThreadD1Ev>
    80004ecc:	00048513          	mv	a0,s1
    80004ed0:	00001097          	auipc	ra,0x1
    80004ed4:	a68080e7          	jalr	-1432(ra) # 80005938 <_ZdlPv>
    80004ed8:	01813083          	ld	ra,24(sp)
    80004edc:	01013403          	ld	s0,16(sp)
    80004ee0:	00813483          	ld	s1,8(sp)
    80004ee4:	02010113          	addi	sp,sp,32
    80004ee8:	00008067          	ret

0000000080004eec <_Z11userWrapperPv>:
#include "../h/syscall_cpp.hpp"


extern void userMain();

void userWrapper(void*){
    80004eec:	ff010113          	addi	sp,sp,-16
    80004ef0:	00113423          	sd	ra,8(sp)
    80004ef4:	00813023          	sd	s0,0(sp)
    80004ef8:	01010413          	addi	s0,sp,16
    userMain();
    80004efc:	fffff097          	auipc	ra,0xfffff
    80004f00:	fdc080e7          	jalr	-36(ra) # 80003ed8 <_Z8userMainv>
}
    80004f04:	00813083          	ld	ra,8(sp)
    80004f08:	00013403          	ld	s0,0(sp)
    80004f0c:	01010113          	addi	sp,sp,16
    80004f10:	00008067          	ret

0000000080004f14 <main>:

int main()
{
    80004f14:	fe010113          	addi	sp,sp,-32
    80004f18:	00113c23          	sd	ra,24(sp)
    80004f1c:	00813823          	sd	s0,16(sp)
    80004f20:	02010413          	addi	s0,sp,32
    MemoryAllocator::initialize();
    80004f24:	00001097          	auipc	ra,0x1
    80004f28:	a64080e7          	jalr	-1436(ra) # 80005988 <_ZN15MemoryAllocator10initializeEv>
    Riscv::w_stvec((uint64)&Riscv::supervisorTrap);
    80004f2c:	ffffc797          	auipc	a5,0xffffc
    80004f30:	0f478793          	addi	a5,a5,244 # 80001020 <_ZN5Riscv14supervisorTrapEv>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80004f34:	10579073          	csrw	stvec,a5

    //1 - user main


    TCB* mainThread;
    thread_create(&mainThread, nullptr, nullptr);
    80004f38:	00000613          	li	a2,0
    80004f3c:	00000593          	li	a1,0
    80004f40:	fe840513          	addi	a0,s0,-24
    80004f44:	00001097          	auipc	ra,0x1
    80004f48:	d94080e7          	jalr	-620(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    TCB* userThread;
    thread_create(&userThread, userWrapper, nullptr);
    80004f4c:	00000613          	li	a2,0
    80004f50:	00000597          	auipc	a1,0x0
    80004f54:	f9c58593          	addi	a1,a1,-100 # 80004eec <_Z11userWrapperPv>
    80004f58:	fe040513          	addi	a0,s0,-32
    80004f5c:	00001097          	auipc	ra,0x1
    80004f60:	d7c080e7          	jalr	-644(ra) # 80005cd8 <_Z13thread_createPP3TCBPFvPvES2_>
    while(!userThread->isFinished()){
    80004f64:	fe043783          	ld	a5,-32(s0)
    void operator delete(void *p) noexcept { MemoryAllocator::mem_free(p); }
    void operator delete[](void *p) noexcept { MemoryAllocator::mem_free(p); }

    ~TCB() { delete[] stack; }

    bool isFinished() const { return finished; }
    80004f68:	0307c783          	lbu	a5,48(a5)
    80004f6c:	00079863          	bnez	a5,80004f7c <main+0x68>
        thread_dispatch();
    80004f70:	00001097          	auipc	ra,0x1
    80004f74:	e18080e7          	jalr	-488(ra) # 80005d88 <_Z15thread_dispatchv>
    80004f78:	fedff06f          	j	80004f64 <main+0x50>
    }


    
    return 0;
}
    80004f7c:	00000513          	li	a0,0
    80004f80:	01813083          	ld	ra,24(sp)
    80004f84:	01013403          	ld	s0,16(sp)
    80004f88:	02010113          	addi	sp,sp,32
    80004f8c:	00008067          	ret

0000000080004f90 <_Z41__static_initialization_and_destruction_0ii>:
                Scheduler::put(thread);
            }
            if(sleepingThreads.movePointer() == -1) break;
        }
    }
}
    80004f90:	ff010113          	addi	sp,sp,-16
    80004f94:	00813423          	sd	s0,8(sp)
    80004f98:	01010413          	addi	s0,sp,16
    80004f9c:	00100793          	li	a5,1
    80004fa0:	00f50863          	beq	a0,a5,80004fb0 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80004fa4:	00813403          	ld	s0,8(sp)
    80004fa8:	01010113          	addi	sp,sp,16
    80004fac:	00008067          	ret
    80004fb0:	000107b7          	lui	a5,0x10
    80004fb4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004fb8:	fef596e3          	bne	a1,a5,80004fa4 <_Z41__static_initialization_and_destruction_0ii+0x14>
    Elem *head, *tail;
    
    Elem* pointer;
    
public:
    List() : head(0), tail(0), pointer(0) {}
    80004fbc:	00006797          	auipc	a5,0x6
    80004fc0:	69478793          	addi	a5,a5,1684 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    80004fc4:	0007b023          	sd	zero,0(a5)
    80004fc8:	0007b423          	sd	zero,8(a5)
    80004fcc:	0007b823          	sd	zero,16(a5)
    80004fd0:	fd5ff06f          	j	80004fa4 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080004fd4 <_ZN3TCB13threadWrapperEv>:
{
    80004fd4:	ff010113          	addi	sp,sp,-16
    80004fd8:	00113423          	sd	ra,8(sp)
    80004fdc:	00813023          	sd	s0,0(sp)
    80004fe0:	01010413          	addi	s0,sp,16
    Riscv::popSppSpie();
    80004fe4:	00000097          	auipc	ra,0x0
    80004fe8:	560080e7          	jalr	1376(ra) # 80005544 <_ZN5Riscv10popSppSpieEv>
    running->body(running->arg);
    80004fec:	00006797          	auipc	a5,0x6
    80004ff0:	62c78793          	addi	a5,a5,1580 # 8000b618 <_ZN3TCB7runningE>
    80004ff4:	0007b783          	ld	a5,0(a5)
    80004ff8:	0007b703          	ld	a4,0(a5)
    80004ffc:	0087b503          	ld	a0,8(a5)
    80005000:	000700e7          	jalr	a4
    thread_exit();
    80005004:	00001097          	auipc	ra,0x1
    80005008:	d5c080e7          	jalr	-676(ra) # 80005d60 <_Z11thread_exitv>
}
    8000500c:	00813083          	ld	ra,8(sp)
    80005010:	00013403          	ld	s0,0(sp)
    80005014:	01010113          	addi	sp,sp,16
    80005018:	00008067          	ret

000000008000501c <_ZN3TCB12createThreadEPFvPvEPmS0_>:
{
    8000501c:	fd010113          	addi	sp,sp,-48
    80005020:	02113423          	sd	ra,40(sp)
    80005024:	02813023          	sd	s0,32(sp)
    80005028:	00913c23          	sd	s1,24(sp)
    8000502c:	01213823          	sd	s2,16(sp)
    80005030:	01313423          	sd	s3,8(sp)
    80005034:	01413023          	sd	s4,0(sp)
    80005038:	03010413          	addi	s0,sp,48
    8000503c:	00050993          	mv	s3,a0
    80005040:	00058913          	mv	s2,a1
    80005044:	00060a13          	mv	s4,a2
    void *operator new(size_t n) { return MemoryAllocator::mem_alloc((n + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE); }
    80005048:	00100513          	li	a0,1
    8000504c:	00001097          	auipc	ra,0x1
    80005050:	998080e7          	jalr	-1640(ra) # 800059e4 <_ZN15MemoryAllocator9mem_allocEm>
    80005054:	00050493          	mv	s1,a0
    TCB(Body body, uint64 *stack, void *arg, uint64 timeSlice) : body(body), arg(arg),
                                                                 stack(body != nullptr ? stack : nullptr),
                                                                 context({(uint64)&threadWrapper,
                                                                          stack != nullptr ? (uint64)&stack[STACK_SIZE] : 0}),
                                                                 timeSlice(timeSlice),
                                                                 finished(false), sleepTime(0)
    80005058:	01353023          	sd	s3,0(a0)
    8000505c:	01453423          	sd	s4,8(a0)
                                                                 stack(body != nullptr ? stack : nullptr),
    80005060:	04098663          	beqz	s3,800050ac <_ZN3TCB12createThreadEPFvPvEPmS0_+0x90>
    80005064:	00090793          	mv	a5,s2
                                                                 finished(false), sleepTime(0)
    80005068:	00f4b823          	sd	a5,16(s1)
    8000506c:	00000797          	auipc	a5,0x0
    80005070:	f6878793          	addi	a5,a5,-152 # 80004fd4 <_ZN3TCB13threadWrapperEv>
    80005074:	00f4bc23          	sd	a5,24(s1)
                                                                          stack != nullptr ? (uint64)&stack[STACK_SIZE] : 0}),
    80005078:	02090e63          	beqz	s2,800050b4 <_ZN3TCB12createThreadEPFvPvEPmS0_+0x98>
    8000507c:	000017b7          	lui	a5,0x1
    80005080:	00f90933          	add	s2,s2,a5
                                                                 finished(false), sleepTime(0)
    80005084:	0324b023          	sd	s2,32(s1)
    80005088:	00200793          	li	a5,2
    8000508c:	02f4b423          	sd	a5,40(s1)
    80005090:	02048823          	sb	zero,48(s1)
    80005094:	0204aa23          	sw	zero,52(s1)
    {
        if (body != nullptr)
    80005098:	02098263          	beqz	s3,800050bc <_ZN3TCB12createThreadEPFvPvEPmS0_+0xa0>
        {
            Scheduler::put(this);
    8000509c:	00048513          	mv	a0,s1
    800050a0:	00000097          	auipc	ra,0x0
    800050a4:	400080e7          	jalr	1024(ra) # 800054a0 <_ZN9Scheduler3putEP3TCB>
    800050a8:	0140006f          	j	800050bc <_ZN3TCB12createThreadEPFvPvEPmS0_+0xa0>
                                                                 stack(body != nullptr ? stack : nullptr),
    800050ac:	00000793          	li	a5,0
    800050b0:	fb9ff06f          	j	80005068 <_ZN3TCB12createThreadEPFvPvEPmS0_+0x4c>
                                                                          stack != nullptr ? (uint64)&stack[STACK_SIZE] : 0}),
    800050b4:	00000913          	li	s2,0
    800050b8:	fcdff06f          	j	80005084 <_ZN3TCB12createThreadEPFvPvEPmS0_+0x68>
        }
        if (running == nullptr) // should only set the main() thread
    800050bc:	00006797          	auipc	a5,0x6
    800050c0:	55c78793          	addi	a5,a5,1372 # 8000b618 <_ZN3TCB7runningE>
    800050c4:	0007b783          	ld	a5,0(a5)
    800050c8:	02078463          	beqz	a5,800050f0 <_ZN3TCB12createThreadEPFvPvEPmS0_+0xd4>
}
    800050cc:	00048513          	mv	a0,s1
    800050d0:	02813083          	ld	ra,40(sp)
    800050d4:	02013403          	ld	s0,32(sp)
    800050d8:	01813483          	ld	s1,24(sp)
    800050dc:	01013903          	ld	s2,16(sp)
    800050e0:	00813983          	ld	s3,8(sp)
    800050e4:	00013a03          	ld	s4,0(sp)
    800050e8:	03010113          	addi	sp,sp,48
    800050ec:	00008067          	ret
        {
            TCB::running = this;
    800050f0:	00006797          	auipc	a5,0x6
    800050f4:	5297b423          	sd	s1,1320(a5) # 8000b618 <_ZN3TCB7runningE>
    return new TCB(body, stack, arg, TIME_SLICE);
    800050f8:	fd5ff06f          	j	800050cc <_ZN3TCB12createThreadEPFvPvEPmS0_+0xb0>
    800050fc:	00050913          	mv	s2,a0
    void operator delete(void *p) noexcept { MemoryAllocator::mem_free(p); }
    80005100:	00048513          	mv	a0,s1
    80005104:	00001097          	auipc	ra,0x1
    80005108:	a44080e7          	jalr	-1468(ra) # 80005b48 <_ZN15MemoryAllocator8mem_freeEPv>
    8000510c:	00090513          	mv	a0,s2
    80005110:	00007097          	auipc	ra,0x7
    80005114:	668080e7          	jalr	1640(ra) # 8000c778 <_Unwind_Resume>

0000000080005118 <_ZN3TCB5yieldEv>:
{
    80005118:	ff010113          	addi	sp,sp,-16
    8000511c:	00813423          	sd	s0,8(sp)
    80005120:	01010413          	addi	s0,sp,16
    __asm__ volatile("ecall");
    80005124:	00000073          	ecall
}
    80005128:	00813403          	ld	s0,8(sp)
    8000512c:	01010113          	addi	sp,sp,16
    80005130:	00008067          	ret

0000000080005134 <_ZN3TCB8dispatchEv>:
{
    80005134:	fe010113          	addi	sp,sp,-32
    80005138:	00113c23          	sd	ra,24(sp)
    8000513c:	00813823          	sd	s0,16(sp)
    80005140:	00913423          	sd	s1,8(sp)
    80005144:	02010413          	addi	s0,sp,32
    TCB *old = running;
    80005148:	00006797          	auipc	a5,0x6
    8000514c:	4d078793          	addi	a5,a5,1232 # 8000b618 <_ZN3TCB7runningE>
    80005150:	0007b483          	ld	s1,0(a5)
    bool isFinished() const { return finished; }
    80005154:	0304c783          	lbu	a5,48(s1)
    if (!old->isFinished())
    80005158:	02078c63          	beqz	a5,80005190 <_ZN3TCB8dispatchEv+0x5c>
    running = Scheduler::get();
    8000515c:	00000097          	auipc	ra,0x0
    80005160:	2d8080e7          	jalr	728(ra) # 80005434 <_ZN9Scheduler3getEv>
    80005164:	00006797          	auipc	a5,0x6
    80005168:	4aa7ba23          	sd	a0,1204(a5) # 8000b618 <_ZN3TCB7runningE>
    contextSwitch(&old->context, &running->context);
    8000516c:	01850593          	addi	a1,a0,24
    80005170:	01848513          	addi	a0,s1,24
    80005174:	ffffc097          	auipc	ra,0xffffc
    80005178:	fbc080e7          	jalr	-68(ra) # 80001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    8000517c:	01813083          	ld	ra,24(sp)
    80005180:	01013403          	ld	s0,16(sp)
    80005184:	00813483          	ld	s1,8(sp)
    80005188:	02010113          	addi	sp,sp,32
    8000518c:	00008067          	ret
        Scheduler::put(old);
    80005190:	00048513          	mv	a0,s1
    80005194:	00000097          	auipc	ra,0x0
    80005198:	30c080e7          	jalr	780(ra) # 800054a0 <_ZN9Scheduler3putEP3TCB>
    8000519c:	fc1ff06f          	j	8000515c <_ZN3TCB8dispatchEv+0x28>

00000000800051a0 <_ZN3TCB17addToSleepingListEPS_i>:
{
    800051a0:	fe010113          	addi	sp,sp,-32
    800051a4:	00113c23          	sd	ra,24(sp)
    800051a8:	00813823          	sd	s0,16(sp)
    800051ac:	00913423          	sd	s1,8(sp)
    800051b0:	01213023          	sd	s2,0(sp)
    800051b4:	02010413          	addi	s0,sp,32
    800051b8:	00050493          	mv	s1,a0
    thread->sleepTime = time;
    800051bc:	02b52a23          	sw	a1,52(a0)
    void addLast(T *data)
    {
        // Elem *elem = new Elem(data, 0);
        size_t size = sizeof(Elem);
        size_t numBlocks = (size % MEM_BLOCK_SIZE == 0) ? size / MEM_BLOCK_SIZE : size / MEM_BLOCK_SIZE + 1;
        Elem *elem = (Elem *)MemoryAllocator::mem_alloc(numBlocks);
    800051c0:	00100513          	li	a0,1
    800051c4:	00001097          	auipc	ra,0x1
    800051c8:	820080e7          	jalr	-2016(ra) # 800059e4 <_ZN15MemoryAllocator9mem_allocEm>
        elem->data = data;
    800051cc:	00953023          	sd	s1,0(a0)
        elem->next = 0;
    800051d0:	00053423          	sd	zero,8(a0)
        if (tail)
    800051d4:	00006797          	auipc	a5,0x6
    800051d8:	47c78793          	addi	a5,a5,1148 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    800051dc:	0087b783          	ld	a5,8(a5)
    800051e0:	04078863          	beqz	a5,80005230 <_ZN3TCB17addToSleepingListEPS_i+0x90>
        {
            tail->next = elem;
    800051e4:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800051e8:	00006797          	auipc	a5,0x6
    800051ec:	46a7b823          	sd	a0,1136(a5) # 8000b658 <_ZN3TCB15sleepingThreadsE+0x8>
    TCB* old = running;
    800051f0:	00006497          	auipc	s1,0x6
    800051f4:	42848493          	addi	s1,s1,1064 # 8000b618 <_ZN3TCB7runningE>
    800051f8:	0004b903          	ld	s2,0(s1)
    running = Scheduler::get();
    800051fc:	00000097          	auipc	ra,0x0
    80005200:	238080e7          	jalr	568(ra) # 80005434 <_ZN9Scheduler3getEv>
    80005204:	00a4b023          	sd	a0,0(s1)
    contextSwitch(&old->context, &TCB::running->context);
    80005208:	01850593          	addi	a1,a0,24
    8000520c:	01890513          	addi	a0,s2,24
    80005210:	ffffc097          	auipc	ra,0xffffc
    80005214:	f20080e7          	jalr	-224(ra) # 80001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80005218:	01813083          	ld	ra,24(sp)
    8000521c:	01013403          	ld	s0,16(sp)
    80005220:	00813483          	ld	s1,8(sp)
    80005224:	00013903          	ld	s2,0(sp)
    80005228:	02010113          	addi	sp,sp,32
    8000522c:	00008067          	ret
        }
        else
        {
            head = tail = elem;
    80005230:	00006797          	auipc	a5,0x6
    80005234:	42078793          	addi	a5,a5,1056 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    80005238:	00a7b423          	sd	a0,8(a5)
    8000523c:	00a7b023          	sd	a0,0(a5)
    80005240:	fb1ff06f          	j	800051f0 <_ZN3TCB17addToSleepingListEPS_i+0x50>

0000000080005244 <_ZN3TCB17checkSleepingListEv>:
        if(!head) return -1;
    80005244:	00006797          	auipc	a5,0x6
    80005248:	40c78793          	addi	a5,a5,1036 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    8000524c:	0007b783          	ld	a5,0(a5)
    80005250:	16078463          	beqz	a5,800053b8 <_ZN3TCB17checkSleepingListEv+0x174>
void TCB::checkSleepingList(){
    80005254:	fe010113          	addi	sp,sp,-32
    80005258:	00113c23          	sd	ra,24(sp)
    8000525c:	00813823          	sd	s0,16(sp)
    80005260:	00913423          	sd	s1,8(sp)
    80005264:	02010413          	addi	s0,sp,32
        pointer = head;
    80005268:	00006717          	auipc	a4,0x6
    8000526c:	3ef73c23          	sd	a5,1016(a4) # 8000b660 <_ZN3TCB15sleepingThreadsE+0x10>
    80005270:	0d80006f          	j	80005348 <_ZN3TCB17checkSleepingListEv+0x104>
        
    }

    T *removeFirst()
    {
        if (!head)
    80005274:	00006797          	auipc	a5,0x6
    80005278:	3dc78793          	addi	a5,a5,988 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    8000527c:	0007b503          	ld	a0,0(a5)
    80005280:	08050e63          	beqz	a0,8000531c <_ZN3TCB17checkSleepingListEv+0xd8>
        {
            return 0;
        }

        Elem *elem = head;
        head = head->next;
    80005284:	00853783          	ld	a5,8(a0)
    80005288:	00006717          	auipc	a4,0x6
    8000528c:	3cf73423          	sd	a5,968(a4) # 8000b650 <_ZN3TCB15sleepingThreadsE>
        if (!head)
    80005290:	00078863          	beqz	a5,800052a0 <_ZN3TCB17checkSleepingListEv+0x5c>
        }


        T *ret = elem->data;
        // delete elem;
        MemoryAllocator::mem_free(elem);
    80005294:	00001097          	auipc	ra,0x1
    80005298:	8b4080e7          	jalr	-1868(ra) # 80005b48 <_ZN15MemoryAllocator8mem_freeEPv>
    8000529c:	0800006f          	j	8000531c <_ZN3TCB17checkSleepingListEv+0xd8>
            tail = 0;
    800052a0:	00006797          	auipc	a5,0x6
    800052a4:	3a07bc23          	sd	zero,952(a5) # 8000b658 <_ZN3TCB15sleepingThreadsE+0x8>
    800052a8:	fedff06f          	j	80005294 <_ZN3TCB17checkSleepingListEv+0x50>
        return head->data;
    }

    T *removeLast()
    {
        if (!head)
    800052ac:	00006797          	auipc	a5,0x6
    800052b0:	3a478793          	addi	a5,a5,932 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    800052b4:	0007b783          	ld	a5,0(a5)
    800052b8:	06078263          	beqz	a5,8000531c <_ZN3TCB17checkSleepingListEv+0xd8>
        {
            return 0;
        }

        Elem *prev = 0;
    800052bc:	00000693          	li	a3,0
        for (Elem *curr = head; curr && curr != tail; curr = curr->next)
    800052c0:	02078063          	beqz	a5,800052e0 <_ZN3TCB17checkSleepingListEv+0x9c>
    800052c4:	00006717          	auipc	a4,0x6
    800052c8:	38c70713          	addi	a4,a4,908 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    800052cc:	00873703          	ld	a4,8(a4)
    800052d0:	00e78863          	beq	a5,a4,800052e0 <_ZN3TCB17checkSleepingListEv+0x9c>
        {
            prev = curr;
    800052d4:	00078693          	mv	a3,a5
        for (Elem *curr = head; curr && curr != tail; curr = curr->next)
    800052d8:	0087b783          	ld	a5,8(a5)
    800052dc:	fe5ff06f          	j	800052c0 <_ZN3TCB17checkSleepingListEv+0x7c>
        }

        Elem *elem = tail;
    800052e0:	00006797          	auipc	a5,0x6
    800052e4:	37078793          	addi	a5,a5,880 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    800052e8:	0087b503          	ld	a0,8(a5)
        if (prev)
    800052ec:	00068e63          	beqz	a3,80005308 <_ZN3TCB17checkSleepingListEv+0xc4>
        {
            prev->next = 0;
    800052f0:	0006b423          	sd	zero,8(a3)
        }
        else
        {
            head = 0;
        }
        tail = prev;
    800052f4:	00006797          	auipc	a5,0x6
    800052f8:	36d7b223          	sd	a3,868(a5) # 8000b658 <_ZN3TCB15sleepingThreadsE+0x8>
        
      
        T *ret = elem->data;
        // delete elem;
        MemoryAllocator::mem_free(elem);
    800052fc:	00001097          	auipc	ra,0x1
    80005300:	84c080e7          	jalr	-1972(ra) # 80005b48 <_ZN15MemoryAllocator8mem_freeEPv>
    80005304:	0180006f          	j	8000531c <_ZN3TCB17checkSleepingListEv+0xd8>
            head = 0;
    80005308:	00006797          	auipc	a5,0x6
    8000530c:	3407b423          	sd	zero,840(a5) # 8000b650 <_ZN3TCB15sleepingThreadsE>
    80005310:	fe5ff06f          	j	800052f4 <_ZN3TCB17checkSleepingListEv+0xb0>
            last->next = pointer->next;
    80005314:	00873783          	ld	a5,8(a4)
    80005318:	00f6b423          	sd	a5,8(a3)
                Scheduler::put(thread);
    8000531c:	00048513          	mv	a0,s1
    80005320:	00000097          	auipc	ra,0x0
    80005324:	180080e7          	jalr	384(ra) # 800054a0 <_ZN9Scheduler3putEP3TCB>
        if(!pointer) return -1;
    80005328:	00006797          	auipc	a5,0x6
    8000532c:	32878793          	addi	a5,a5,808 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    80005330:	0107b783          	ld	a5,16(a5)
    80005334:	06078863          	beqz	a5,800053a4 <_ZN3TCB17checkSleepingListEv+0x160>
        pointer = pointer->next;
    80005338:	0087b783          	ld	a5,8(a5)
    8000533c:	00006717          	auipc	a4,0x6
    80005340:	32f73223          	sd	a5,804(a4) # 8000b660 <_ZN3TCB15sleepingThreadsE+0x10>
        if(!pointer) return -1;
    80005344:	06078063          	beqz	a5,800053a4 <_ZN3TCB17checkSleepingListEv+0x160>
        return pointer->data;
    80005348:	00006797          	auipc	a5,0x6
    8000534c:	30878793          	addi	a5,a5,776 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    80005350:	0107b783          	ld	a5,16(a5)
    80005354:	0007b483          	ld	s1,0(a5)
            thread->sleepTime--;
    80005358:	0344a783          	lw	a5,52(s1)
    8000535c:	fff7879b          	addiw	a5,a5,-1
    80005360:	0007871b          	sext.w	a4,a5
    80005364:	02f4aa23          	sw	a5,52(s1)
            if(thread->sleepTime <= 0){
    80005368:	fce040e3          	bgtz	a4,80005328 <_ZN3TCB17checkSleepingListEv+0xe4>
        if(pointer == head) removeFirst();
    8000536c:	00006797          	auipc	a5,0x6
    80005370:	2e478793          	addi	a5,a5,740 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    80005374:	0107b703          	ld	a4,16(a5)
    80005378:	0007b783          	ld	a5,0(a5)
    8000537c:	eef70ce3          	beq	a4,a5,80005274 <_ZN3TCB17checkSleepingListEv+0x30>
        else if(pointer == tail) removeLast();
    80005380:	00006697          	auipc	a3,0x6
    80005384:	2d068693          	addi	a3,a3,720 # 8000b650 <_ZN3TCB15sleepingThreadsE>
    80005388:	0086b683          	ld	a3,8(a3)
    8000538c:	f2d700e3          	beq	a4,a3,800052ac <_ZN3TCB17checkSleepingListEv+0x68>
            Elem* last = nullptr;
    80005390:	00000693          	li	a3,0
            while(curr != pointer){ last = curr; curr = curr->next; }
    80005394:	f8f700e3          	beq	a4,a5,80005314 <_ZN3TCB17checkSleepingListEv+0xd0>
    80005398:	00078693          	mv	a3,a5
    8000539c:	0087b783          	ld	a5,8(a5)
    800053a0:	ff5ff06f          	j	80005394 <_ZN3TCB17checkSleepingListEv+0x150>
}
    800053a4:	01813083          	ld	ra,24(sp)
    800053a8:	01013403          	ld	s0,16(sp)
    800053ac:	00813483          	ld	s1,8(sp)
    800053b0:	02010113          	addi	sp,sp,32
    800053b4:	00008067          	ret
    800053b8:	00008067          	ret

00000000800053bc <_GLOBAL__sub_I__ZN3TCB7runningE>:
    800053bc:	ff010113          	addi	sp,sp,-16
    800053c0:	00113423          	sd	ra,8(sp)
    800053c4:	00813023          	sd	s0,0(sp)
    800053c8:	01010413          	addi	s0,sp,16
    800053cc:	000105b7          	lui	a1,0x10
    800053d0:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    800053d4:	00100513          	li	a0,1
    800053d8:	00000097          	auipc	ra,0x0
    800053dc:	bb8080e7          	jalr	-1096(ra) # 80004f90 <_Z41__static_initialization_and_destruction_0ii>
    800053e0:	00813083          	ld	ra,8(sp)
    800053e4:	00013403          	ld	s0,0(sp)
    800053e8:	01010113          	addi	sp,sp,16
    800053ec:	00008067          	ret

00000000800053f0 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(TCB *ccb)
{
    readyThreadQueue.addLast(ccb);
}
    800053f0:	ff010113          	addi	sp,sp,-16
    800053f4:	00813423          	sd	s0,8(sp)
    800053f8:	01010413          	addi	s0,sp,16
    800053fc:	00100793          	li	a5,1
    80005400:	00f50863          	beq	a0,a5,80005410 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80005404:	00813403          	ld	s0,8(sp)
    80005408:	01010113          	addi	sp,sp,16
    8000540c:	00008067          	ret
    80005410:	000107b7          	lui	a5,0x10
    80005414:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005418:	fef596e3          	bne	a1,a5,80005404 <_Z41__static_initialization_and_destruction_0ii+0x14>
    List() : head(0), tail(0), pointer(0) {}
    8000541c:	00006797          	auipc	a5,0x6
    80005420:	24c78793          	addi	a5,a5,588 # 8000b668 <_ZN9Scheduler16readyThreadQueueE>
    80005424:	0007b023          	sd	zero,0(a5)
    80005428:	0007b423          	sd	zero,8(a5)
    8000542c:	0007b823          	sd	zero,16(a5)
    80005430:	fd5ff06f          	j	80005404 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080005434 <_ZN9Scheduler3getEv>:
{
    80005434:	fe010113          	addi	sp,sp,-32
    80005438:	00113c23          	sd	ra,24(sp)
    8000543c:	00813823          	sd	s0,16(sp)
    80005440:	00913423          	sd	s1,8(sp)
    80005444:	02010413          	addi	s0,sp,32
        if (!head)
    80005448:	00006797          	auipc	a5,0x6
    8000544c:	22078793          	addi	a5,a5,544 # 8000b668 <_ZN9Scheduler16readyThreadQueueE>
    80005450:	0007b503          	ld	a0,0(a5)
    80005454:	04050263          	beqz	a0,80005498 <_ZN9Scheduler3getEv+0x64>
        head = head->next;
    80005458:	00853783          	ld	a5,8(a0)
    8000545c:	00006717          	auipc	a4,0x6
    80005460:	20f73623          	sd	a5,524(a4) # 8000b668 <_ZN9Scheduler16readyThreadQueueE>
        if (!head)
    80005464:	02078463          	beqz	a5,8000548c <_ZN9Scheduler3getEv+0x58>
        T *ret = elem->data;
    80005468:	00053483          	ld	s1,0(a0)
        MemoryAllocator::mem_free(elem);
    8000546c:	00000097          	auipc	ra,0x0
    80005470:	6dc080e7          	jalr	1756(ra) # 80005b48 <_ZN15MemoryAllocator8mem_freeEPv>
}
    80005474:	00048513          	mv	a0,s1
    80005478:	01813083          	ld	ra,24(sp)
    8000547c:	01013403          	ld	s0,16(sp)
    80005480:	00813483          	ld	s1,8(sp)
    80005484:	02010113          	addi	sp,sp,32
    80005488:	00008067          	ret
            tail = 0;
    8000548c:	00006797          	auipc	a5,0x6
    80005490:	1e07b223          	sd	zero,484(a5) # 8000b670 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80005494:	fd5ff06f          	j	80005468 <_ZN9Scheduler3getEv+0x34>
            return 0;
    80005498:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    8000549c:	fd9ff06f          	j	80005474 <_ZN9Scheduler3getEv+0x40>

00000000800054a0 <_ZN9Scheduler3putEP3TCB>:
{
    800054a0:	fe010113          	addi	sp,sp,-32
    800054a4:	00113c23          	sd	ra,24(sp)
    800054a8:	00813823          	sd	s0,16(sp)
    800054ac:	00913423          	sd	s1,8(sp)
    800054b0:	02010413          	addi	s0,sp,32
    800054b4:	00050493          	mv	s1,a0
        Elem *elem = (Elem *)MemoryAllocator::mem_alloc(numBlocks);
    800054b8:	00100513          	li	a0,1
    800054bc:	00000097          	auipc	ra,0x0
    800054c0:	528080e7          	jalr	1320(ra) # 800059e4 <_ZN15MemoryAllocator9mem_allocEm>
        elem->data = data;
    800054c4:	00953023          	sd	s1,0(a0)
        elem->next = 0;
    800054c8:	00053423          	sd	zero,8(a0)
        if (tail)
    800054cc:	00006797          	auipc	a5,0x6
    800054d0:	19c78793          	addi	a5,a5,412 # 8000b668 <_ZN9Scheduler16readyThreadQueueE>
    800054d4:	0087b783          	ld	a5,8(a5)
    800054d8:	02078263          	beqz	a5,800054fc <_ZN9Scheduler3putEP3TCB+0x5c>
            tail->next = elem;
    800054dc:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800054e0:	00006797          	auipc	a5,0x6
    800054e4:	18a7b823          	sd	a0,400(a5) # 8000b670 <_ZN9Scheduler16readyThreadQueueE+0x8>
}
    800054e8:	01813083          	ld	ra,24(sp)
    800054ec:	01013403          	ld	s0,16(sp)
    800054f0:	00813483          	ld	s1,8(sp)
    800054f4:	02010113          	addi	sp,sp,32
    800054f8:	00008067          	ret
            head = tail = elem;
    800054fc:	00006797          	auipc	a5,0x6
    80005500:	16c78793          	addi	a5,a5,364 # 8000b668 <_ZN9Scheduler16readyThreadQueueE>
    80005504:	00a7b423          	sd	a0,8(a5)
    80005508:	00a7b023          	sd	a0,0(a5)
    8000550c:	fddff06f          	j	800054e8 <_ZN9Scheduler3putEP3TCB+0x48>

0000000080005510 <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80005510:	ff010113          	addi	sp,sp,-16
    80005514:	00113423          	sd	ra,8(sp)
    80005518:	00813023          	sd	s0,0(sp)
    8000551c:	01010413          	addi	s0,sp,16
    80005520:	000105b7          	lui	a1,0x10
    80005524:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80005528:	00100513          	li	a0,1
    8000552c:	00000097          	auipc	ra,0x0
    80005530:	ec4080e7          	jalr	-316(ra) # 800053f0 <_Z41__static_initialization_and_destruction_0ii>
    80005534:	00813083          	ld	ra,8(sp)
    80005538:	00013403          	ld	s0,0(sp)
    8000553c:	01010113          	addi	sp,sp,16
    80005540:	00008067          	ret

0000000080005544 <_ZN5Riscv10popSppSpieEv>:

const uint64 ECALL_USER = 0x0000000000000008UL;
const uint64 ECALL_SUPER = 0x0000000000000009UL;

void Riscv::popSppSpie()
{
    80005544:	ff010113          	addi	sp,sp,-16
    80005548:	00813423          	sd	s0,8(sp)
    8000554c:	01010413          	addi	s0,sp,16
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::mc_sstatus(uint64 mask)
{
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80005550:	10000793          	li	a5,256
    80005554:	1007b073          	csrc	sstatus,a5
    mc_sstatus(Riscv::SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    80005558:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    8000555c:	10200073          	sret
}
    80005560:	00813403          	ld	s0,8(sp)
    80005564:	01010113          	addi	sp,sp,16
    80005568:	00008067          	ret

000000008000556c <_ZN5Riscv20handleSupervisorTrapEv>:

void Riscv::handleSupervisorTrap()
{
    8000556c:	f9010113          	addi	sp,sp,-112
    80005570:	06113423          	sd	ra,104(sp)
    80005574:	06813023          	sd	s0,96(sp)
    80005578:	04913c23          	sd	s1,88(sp)
    8000557c:	05213823          	sd	s2,80(sp)
    80005580:	07010413          	addi	s0,sp,112
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80005584:	142027f3          	csrr	a5,scause
    80005588:	faf43c23          	sd	a5,-72(s0)
    return scause;
    8000558c:	fb843703          	ld	a4,-72(s0)
    uint64 scause = r_scause();

    if (scause == ECALL_USER || scause == ECALL_SUPER)
    80005590:	ff870693          	addi	a3,a4,-8
    80005594:	00100793          	li	a5,1
    80005598:	02d7f863          	bgeu	a5,a3,800055c8 <_ZN5Riscv20handleSupervisorTrapEv+0x5c>
            __putc(character);
        }
        w_sstatus(sstatus);
        w_sepc(new_sepc);
    }
    else if (scause == 0x8000000000000001UL)
    8000559c:	fff00793          	li	a5,-1
    800055a0:	03f79793          	slli	a5,a5,0x3f
    800055a4:	00178793          	addi	a5,a5,1
    800055a8:	2af70c63          	beq	a4,a5,80005860 <_ZN5Riscv20handleSupervisorTrapEv+0x2f4>
            TCB::dispatch();
            w_sstatus(sstatus);
            w_sepc(sepc);
        }
    }
    else if (scause == 0x8000000000000009UL)
    800055ac:	fff00793          	li	a5,-1
    800055b0:	03f79793          	slli	a5,a5,0x3f
    800055b4:	00978793          	addi	a5,a5,9
    800055b8:	0cf71e63          	bne	a4,a5,80005694 <_ZN5Riscv20handleSupervisorTrapEv+0x128>
    {
        // interrupt: yes; cause code: supervisor external interrupt (PLIC; could be keyboard)
        console_handler();
    800055bc:	00003097          	auipc	ra,0x3
    800055c0:	0e4080e7          	jalr	228(ra) # 800086a0 <console_handler>
    }
    else
    {
        // unexpected trap cause
    }
}
    800055c4:	0d00006f          	j	80005694 <_ZN5Riscv20handleSupervisorTrapEv+0x128>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800055c8:	141027f3          	csrr	a5,sepc
    800055cc:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    800055d0:	fc843783          	ld	a5,-56(s0)
        uint64 volatile new_sepc = r_sepc() + 4;
    800055d4:	00478793          	addi	a5,a5,4
    800055d8:	f8f43c23          	sd	a5,-104(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800055dc:	100027f3          	csrr	a5,sstatus
    800055e0:	fcf43023          	sd	a5,-64(s0)
    return sstatus;
    800055e4:	fc043783          	ld	a5,-64(s0)
        uint64 volatile sstatus = r_sstatus();
    800055e8:	faf43023          	sd	a5,-96(s0)
        __asm__ volatile("ld %0, 10*8(s0)" : "=r"(a0)); // read a0
    800055ec:	05043783          	ld	a5,80(s0)
        if (a0 == MEM_ALLOC)
    800055f0:	00100713          	li	a4,1
    800055f4:	08e78063          	beq	a5,a4,80005674 <_ZN5Riscv20handleSupervisorTrapEv+0x108>
        else if (a0 == MEM_FREE)
    800055f8:	00200713          	li	a4,2
    800055fc:	0ae78863          	beq	a5,a4,800056ac <_ZN5Riscv20handleSupervisorTrapEv+0x140>
        else if (a0 == THREAD_CREATE)
    80005600:	01100713          	li	a4,17
    80005604:	0ae78e63          	beq	a5,a4,800056c0 <_ZN5Riscv20handleSupervisorTrapEv+0x154>
        else if(a0 == THREAD_DISPATCH)
    80005608:	01300713          	li	a4,19
    8000560c:	0ee78463          	beq	a5,a4,800056f4 <_ZN5Riscv20handleSupervisorTrapEv+0x188>
        else if(a0 == THREAD_EXIT)
    80005610:	01200713          	li	a4,18
    80005614:	0ee78663          	beq	a5,a4,80005700 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
        else if (a0 == THREAD_SLEEP) {
    80005618:	01400713          	li	a4,20
    8000561c:	10e78263          	beq	a5,a4,80005720 <_ZN5Riscv20handleSupervisorTrapEv+0x1b4>
        else if(a0 == SEM_OPEN)
    80005620:	02100713          	li	a4,33
    80005624:	10e78e63          	beq	a5,a4,80005740 <_ZN5Riscv20handleSupervisorTrapEv+0x1d4>
        else if(a0 == SEM_WAIT){
    80005628:	02300713          	li	a4,35
    8000562c:	14e78e63          	beq	a5,a4,80005788 <_ZN5Riscv20handleSupervisorTrapEv+0x21c>
        else if(a0 == SEM_CLOSE){
    80005630:	02200713          	li	a4,34
    80005634:	16e78e63          	beq	a5,a4,800057b0 <_ZN5Riscv20handleSupervisorTrapEv+0x244>
        else if (a0 == SEM_SIGNAL){
    80005638:	02400713          	li	a4,36
    8000563c:	18e78e63          	beq	a5,a4,800057d8 <_ZN5Riscv20handleSupervisorTrapEv+0x26c>
        else if(a0 == SEM_TIMEDWAIT) {
    80005640:	02500713          	li	a4,37
    80005644:	1ae78e63          	beq	a5,a4,80005800 <_ZN5Riscv20handleSupervisorTrapEv+0x294>
        else if (a0 == SEM_TRYWAIT){
    80005648:	02600713          	li	a4,38
    8000564c:	1ee78063          	beq	a5,a4,8000582c <_ZN5Riscv20handleSupervisorTrapEv+0x2c0>
        else if(a0 == GETC){
    80005650:	04100713          	li	a4,65
    80005654:	1ee78e63          	beq	a5,a4,80005850 <_ZN5Riscv20handleSupervisorTrapEv+0x2e4>
        else if(a0 == PUTC){
    80005658:	04200713          	li	a4,66
    8000565c:	02e79463          	bne	a5,a4,80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(character));
    80005660:	05843503          	ld	a0,88(s0)
            __putc(character);
    80005664:	0ff57513          	andi	a0,a0,255
    80005668:	00003097          	auipc	ra,0x3
    8000566c:	fc4080e7          	jalr	-60(ra) # 8000862c <__putc>
    80005670:	0140006f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
            __asm__ volatile("ld %0, 12*8(s0)" : "=r"(size)); // read a2
    80005674:	06043503          	ld	a0,96(s0)
            void *returnVal = MemoryAllocator::mem_alloc(size);
    80005678:	00000097          	auipc	ra,0x0
    8000567c:	36c080e7          	jalr	876(ra) # 800059e4 <_ZN15MemoryAllocator9mem_allocEm>
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(returnVal)); // store return value in a0
    80005680:	04a43823          	sd	a0,80(s0)
        w_sstatus(sstatus);
    80005684:	fa043783          	ld	a5,-96(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80005688:	10079073          	csrw	sstatus,a5
        w_sepc(new_sepc);
    8000568c:	f9843783          	ld	a5,-104(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80005690:	14179073          	csrw	sepc,a5
}
    80005694:	06813083          	ld	ra,104(sp)
    80005698:	06013403          	ld	s0,96(sp)
    8000569c:	05813483          	ld	s1,88(sp)
    800056a0:	05013903          	ld	s2,80(sp)
    800056a4:	07010113          	addi	sp,sp,112
    800056a8:	00008067          	ret
            __asm__ volatile("ld %0, 12*8(s0)" : "=r"(addr)); // read a2
    800056ac:	06043503          	ld	a0,96(s0)
            int status = MemoryAllocator::mem_free(addr);
    800056b0:	00000097          	auipc	ra,0x0
    800056b4:	498080e7          	jalr	1176(ra) # 80005b48 <_ZN15MemoryAllocator8mem_freeEPv>
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status)); // store status in a0
    800056b8:	04a43823          	sd	a0,80(s0)
    800056bc:	fc9ff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(handle));
    800056c0:	05843483          	ld	s1,88(s0)
            __asm__ volatile("ld %0, 12*8(s0)" : "=r"(start_routine));
    800056c4:	06043503          	ld	a0,96(s0)
            __asm__ volatile("ld %0, 13*8(s0)" : "=r"(arg));
    800056c8:	06843603          	ld	a2,104(s0)
            __asm__ volatile("ld %0, 14*8(s0)" : "=r"(stack));
    800056cc:	07043583          	ld	a1,112(s0)
            *handle = TCB::createThread((TCB::Body)start_routine, stack, arg);
    800056d0:	00000097          	auipc	ra,0x0
    800056d4:	94c080e7          	jalr	-1716(ra) # 8000501c <_ZN3TCB12createThreadEPFvPvEPmS0_>
    800056d8:	00a4b023          	sd	a0,0(s1)
            if (*handle == nullptr)
    800056dc:	00050863          	beqz	a0,800056ec <_ZN5Riscv20handleSupervisorTrapEv+0x180>
            uint64 status = 0;
    800056e0:	00000793          	li	a5,0
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
    800056e4:	04f43823          	sd	a5,80(s0)
    800056e8:	f9dff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
                status = -1;
    800056ec:	fff00793          	li	a5,-1
    800056f0:	ff5ff06f          	j	800056e4 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
            TCB::dispatch();
    800056f4:	00000097          	auipc	ra,0x0
    800056f8:	a40080e7          	jalr	-1472(ra) # 80005134 <_ZN3TCB8dispatchEv>
    800056fc:	f89ff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
            TCB::running->setFinished(true);
    80005700:	00006797          	auipc	a5,0x6
    80005704:	f1878793          	addi	a5,a5,-232 # 8000b618 <_ZN3TCB7runningE>
    80005708:	0007b783          	ld	a5,0(a5)
    void setFinished(bool value) { finished = value; }
    8000570c:	00100713          	li	a4,1
    80005710:	02e78823          	sb	a4,48(a5)
            TCB::dispatch();
    80005714:	00000097          	auipc	ra,0x0
    80005718:	a20080e7          	jalr	-1504(ra) # 80005134 <_ZN3TCB8dispatchEv>
    8000571c:	f69ff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(time));
    80005720:	05843583          	ld	a1,88(s0)
            TCB::addToSleepingList(TCB::running, time);
    80005724:	0005859b          	sext.w	a1,a1
    80005728:	00006797          	auipc	a5,0x6
    8000572c:	ef078793          	addi	a5,a5,-272 # 8000b618 <_ZN3TCB7runningE>
    80005730:	0007b503          	ld	a0,0(a5)
    80005734:	00000097          	auipc	ra,0x0
    80005738:	a6c080e7          	jalr	-1428(ra) # 800051a0 <_ZN3TCB17addToSleepingListEPS_i>
    8000573c:	f49ff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(handle));
    80005740:	05843483          	ld	s1,88(s0)
            __asm__ volatile("ld %0, 12*8(s0)" : "=r"(init));
    80005744:	06043903          	ld	s2,96(s0)

#include "tcb.hpp"

class mySem{
public:
    void *operator new(size_t n) { return MemoryAllocator::mem_alloc((n + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE); }
    80005748:	00100513          	li	a0,1
    8000574c:	00000097          	auipc	ra,0x0
    80005750:	298080e7          	jalr	664(ra) # 800059e4 <_ZN15MemoryAllocator9mem_allocEm>
    void operator delete(void *p) noexcept { MemoryAllocator::mem_free(p);}

    mySem (int initValue=1) : val(initValue) {}
    80005754:	01252023          	sw	s2,0(a0)
    80005758:	00050223          	sb	zero,4(a0)
    List() : head(0), tail(0), pointer(0) {}
    8000575c:	00053423          	sd	zero,8(a0)
    80005760:	00053823          	sd	zero,16(a0)
    80005764:	00053c23          	sd	zero,24(a0)
    80005768:	02050023          	sb	zero,32(a0)
            *handle = mySem::createSemaphore((int)init);
    8000576c:	00a4b023          	sd	a0,0(s1)
            if (*handle == nullptr)
    80005770:	00050863          	beqz	a0,80005780 <_ZN5Riscv20handleSupervisorTrapEv+0x214>
            uint64 status = 0;
    80005774:	00000793          	li	a5,0
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
    80005778:	04f43823          	sd	a5,80(s0)
    8000577c:	f09ff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
                status = -1;
    80005780:	fff00793          	li	a5,-1
    80005784:	ff5ff06f          	j	80005778 <_ZN5Riscv20handleSupervisorTrapEv+0x20c>
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(id));
    80005788:	05843503          	ld	a0,88(s0)
    void signal();
    void deblock();
    int trywait();
    void addToWaitingList(time_t period);
    void checkWaitingList();
    bool isClosed(){return closed;}
    8000578c:	00454783          	lbu	a5,4(a0)
            if(id->isClosed()){
    80005790:	00078863          	beqz	a5,800057a0 <_ZN5Riscv20handleSupervisorTrapEv+0x234>
                status = -1;
    80005794:	fff00793          	li	a5,-1
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
    80005798:	04f43823          	sd	a5,80(s0)
    8000579c:	ee9ff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
                id->wait();
    800057a0:	00001097          	auipc	ra,0x1
    800057a4:	940080e7          	jalr	-1728(ra) # 800060e0 <_ZN5mySem4waitEv>
            uint64 status = 0;
    800057a8:	00000793          	li	a5,0
    800057ac:	fedff06f          	j	80005798 <_ZN5Riscv20handleSupervisorTrapEv+0x22c>
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(handle));
    800057b0:	05843503          	ld	a0,88(s0)
    800057b4:	00454783          	lbu	a5,4(a0)
            if(handle->isClosed())
    800057b8:	00078863          	beqz	a5,800057c8 <_ZN5Riscv20handleSupervisorTrapEv+0x25c>
                status = -1;
    800057bc:	fff00793          	li	a5,-1
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
    800057c0:	04f43823          	sd	a5,80(s0)
    800057c4:	ec1ff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
                handle->close();
    800057c8:	00001097          	auipc	ra,0x1
    800057cc:	810080e7          	jalr	-2032(ra) # 80005fd8 <_ZN5mySem5closeEv>
            uint64 status = 0;
    800057d0:	00000793          	li	a5,0
    800057d4:	fedff06f          	j	800057c0 <_ZN5Riscv20handleSupervisorTrapEv+0x254>
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(handle));
    800057d8:	05843503          	ld	a0,88(s0)
    800057dc:	00454783          	lbu	a5,4(a0)
            if(handle->isClosed()){
    800057e0:	00078863          	beqz	a5,800057f0 <_ZN5Riscv20handleSupervisorTrapEv+0x284>
                status = -1;
    800057e4:	fff00793          	li	a5,-1
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
    800057e8:	04f43823          	sd	a5,80(s0)
    800057ec:	e99ff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
                handle->signal();
    800057f0:	00001097          	auipc	ra,0x1
    800057f4:	998080e7          	jalr	-1640(ra) # 80006188 <_ZN5mySem6signalEv>
            uint64 status = 0;
    800057f8:	00000793          	li	a5,0
    800057fc:	fedff06f          	j	800057e8 <_ZN5Riscv20handleSupervisorTrapEv+0x27c>
            __asm__ volatile("ld %0, 12*8(s0)" : "=r"(id));
    80005800:	06043503          	ld	a0,96(s0)
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(time));
    80005804:	05843583          	ld	a1,88(s0)
    80005808:	00454783          	lbu	a5,4(a0)
            if(id->isClosed())
    8000580c:	00078863          	beqz	a5,8000581c <_ZN5Riscv20handleSupervisorTrapEv+0x2b0>
                status = -1;
    80005810:	fff00793          	li	a5,-1
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
    80005814:	04f43823          	sd	a5,80(s0)
    80005818:	e6dff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
                id->addToWaitingList(time);
    8000581c:	00001097          	auipc	ra,0x1
    80005820:	9dc080e7          	jalr	-1572(ra) # 800061f8 <_ZN5mySem16addToWaitingListEm>
            uint64 status = 0;
    80005824:	00000793          	li	a5,0
    80005828:	fedff06f          	j	80005814 <_ZN5Riscv20handleSupervisorTrapEv+0x2a8>
            __asm__ volatile("ld %0, 11*8(s0)" : "=r"(handle));
    8000582c:	05843503          	ld	a0,88(s0)
    80005830:	00454783          	lbu	a5,4(a0)
            if(handle->isClosed()){
    80005834:	00078863          	beqz	a5,80005844 <_ZN5Riscv20handleSupervisorTrapEv+0x2d8>
                status = -1;
    80005838:	fff00513          	li	a0,-1
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(status));
    8000583c:	04a43823          	sd	a0,80(s0)
    80005840:	e45ff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
                status = handle->trywait();
    80005844:	00001097          	auipc	ra,0x1
    80005848:	980080e7          	jalr	-1664(ra) # 800061c4 <_ZN5mySem7trywaitEv>
    8000584c:	ff1ff06f          	j	8000583c <_ZN5Riscv20handleSupervisorTrapEv+0x2d0>
            char character = __getc();
    80005850:	00003097          	auipc	ra,0x3
    80005854:	e18080e7          	jalr	-488(ra) # 80008668 <__getc>
            __asm__ volatile("sd %0, 10*8(s0)" ::"r"(character));
    80005858:	04a43823          	sd	a0,80(s0)
    8000585c:	e29ff06f          	j	80005684 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80005860:	00200793          	li	a5,2
    80005864:	1447b073          	csrc	sip,a5
        TCB::timeSliceCounter++;
    80005868:	00006497          	auipc	s1,0x6
    8000586c:	da848493          	addi	s1,s1,-600 # 8000b610 <_ZN3TCB16timeSliceCounterE>
    80005870:	0004b783          	ld	a5,0(s1)
    80005874:	00178793          	addi	a5,a5,1
    80005878:	00f4b023          	sd	a5,0(s1)
        TCB::checkSleepingList(); //wakes up sleeping threads if sleep time exceeded
    8000587c:	00000097          	auipc	ra,0x0
    80005880:	9c8080e7          	jalr	-1592(ra) # 80005244 <_ZN3TCB17checkSleepingListEv>
        mySem::checkAllTimedSems(); //wakes up timed-waiting threads waitinng on semaphores
    80005884:	00001097          	auipc	ra,0x1
    80005888:	bf8080e7          	jalr	-1032(ra) # 8000647c <_ZN5mySem17checkAllTimedSemsEv>
        if (TCB::timeSliceCounter >= TCB::running->getTimeSlice())
    8000588c:	00006797          	auipc	a5,0x6
    80005890:	d8c78793          	addi	a5,a5,-628 # 8000b618 <_ZN3TCB7runningE>
    80005894:	0007b783          	ld	a5,0(a5)
    uint64 getTimeSlice() const { return timeSlice; }
    80005898:	0287b783          	ld	a5,40(a5)
    8000589c:	0004b703          	ld	a4,0(s1)
    800058a0:	def76ae3          	bltu	a4,a5,80005694 <_ZN5Riscv20handleSupervisorTrapEv+0x128>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800058a4:	141027f3          	csrr	a5,sepc
    800058a8:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    800058ac:	fd843783          	ld	a5,-40(s0)
            uint64 volatile sepc = r_sepc(); // dispatch will change the context
    800058b0:	faf43423          	sd	a5,-88(s0)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800058b4:	100027f3          	csrr	a5,sstatus
    800058b8:	fcf43823          	sd	a5,-48(s0)
    return sstatus;
    800058bc:	fd043783          	ld	a5,-48(s0)
            uint64 volatile sstatus = r_sstatus();
    800058c0:	faf43823          	sd	a5,-80(s0)
            TCB::timeSliceCounter = 0;
    800058c4:	00006797          	auipc	a5,0x6
    800058c8:	d407b623          	sd	zero,-692(a5) # 8000b610 <_ZN3TCB16timeSliceCounterE>
            TCB::dispatch();
    800058cc:	00000097          	auipc	ra,0x0
    800058d0:	868080e7          	jalr	-1944(ra) # 80005134 <_ZN3TCB8dispatchEv>
            w_sstatus(sstatus);
    800058d4:	fb043783          	ld	a5,-80(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800058d8:	10079073          	csrw	sstatus,a5
            w_sepc(sepc);
    800058dc:	fa843783          	ld	a5,-88(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800058e0:	14179073          	csrw	sepc,a5
    800058e4:	db1ff06f          	j	80005694 <_ZN5Riscv20handleSupervisorTrapEv+0x128>

00000000800058e8 <_Znwm>:
#include "../h/syscall_c.hpp"

using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    800058e8:	ff010113          	addi	sp,sp,-16
    800058ec:	00113423          	sd	ra,8(sp)
    800058f0:	00813023          	sd	s0,0(sp)
    800058f4:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    800058f8:	00000097          	auipc	ra,0x0
    800058fc:	344080e7          	jalr	836(ra) # 80005c3c <_Z9mem_allocm>
}
    80005900:	00813083          	ld	ra,8(sp)
    80005904:	00013403          	ld	s0,0(sp)
    80005908:	01010113          	addi	sp,sp,16
    8000590c:	00008067          	ret

0000000080005910 <_Znam>:

void *operator new[](size_t n)
{
    80005910:	ff010113          	addi	sp,sp,-16
    80005914:	00113423          	sd	ra,8(sp)
    80005918:	00813023          	sd	s0,0(sp)
    8000591c:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80005920:	00000097          	auipc	ra,0x0
    80005924:	31c080e7          	jalr	796(ra) # 80005c3c <_Z9mem_allocm>
}
    80005928:	00813083          	ld	ra,8(sp)
    8000592c:	00013403          	ld	s0,0(sp)
    80005930:	01010113          	addi	sp,sp,16
    80005934:	00008067          	ret

0000000080005938 <_ZdlPv>:

void operator delete(void *p) noexcept
{
    80005938:	ff010113          	addi	sp,sp,-16
    8000593c:	00113423          	sd	ra,8(sp)
    80005940:	00813023          	sd	s0,0(sp)
    80005944:	01010413          	addi	s0,sp,16
    mem_free(p);
    80005948:	00000097          	auipc	ra,0x0
    8000594c:	34c080e7          	jalr	844(ra) # 80005c94 <_Z8mem_freePv>
}
    80005950:	00813083          	ld	ra,8(sp)
    80005954:	00013403          	ld	s0,0(sp)
    80005958:	01010113          	addi	sp,sp,16
    8000595c:	00008067          	ret

0000000080005960 <_ZdaPv>:

void operator delete[](void *p) noexcept
{
    80005960:	ff010113          	addi	sp,sp,-16
    80005964:	00113423          	sd	ra,8(sp)
    80005968:	00813023          	sd	s0,0(sp)
    8000596c:	01010413          	addi	s0,sp,16
    mem_free(p);
    80005970:	00000097          	auipc	ra,0x0
    80005974:	324080e7          	jalr	804(ra) # 80005c94 <_Z8mem_freePv>
    80005978:	00813083          	ld	ra,8(sp)
    8000597c:	00013403          	ld	s0,0(sp)
    80005980:	01010113          	addi	sp,sp,16
    80005984:	00008067          	ret

0000000080005988 <_ZN15MemoryAllocator10initializeEv>:

FreeMem *MemoryAllocator::fmem_head = nullptr;
const size_t HEADER_SIZE = MEM_BLOCK_SIZE;

void MemoryAllocator::initialize()
{
    80005988:	ff010113          	addi	sp,sp,-16
    8000598c:	00813423          	sd	s0,8(sp)
    80005990:	01010413          	addi	s0,sp,16
    fmem_head = (FreeMem *)((size_t)HEAP_START_ADDR + MEM_BLOCK_SIZE - (size_t)HEAP_START_ADDR % MEM_BLOCK_SIZE);
    80005994:	00006797          	auipc	a5,0x6
    80005998:	bcc78793          	addi	a5,a5,-1076 # 8000b560 <HEAP_START_ADDR>
    8000599c:	0007b783          	ld	a5,0(a5)
    800059a0:	fc07f793          	andi	a5,a5,-64
    800059a4:	04078693          	addi	a3,a5,64
    800059a8:	00006717          	auipc	a4,0x6
    800059ac:	c7870713          	addi	a4,a4,-904 # 8000b620 <_ZN15MemoryAllocator9fmem_headE>
    800059b0:	00d73023          	sd	a3,0(a4)
    fmem_head->next = nullptr;
    800059b4:	0407b023          	sd	zero,64(a5)
    fmem_head->prev = nullptr;
    800059b8:	00073703          	ld	a4,0(a4)
    800059bc:	00073423          	sd	zero,8(a4)
    fmem_head->size = (size_t)HEAP_END_ADDR - (size_t)fmem_head - HEADER_SIZE;
    800059c0:	00006797          	auipc	a5,0x6
    800059c4:	b9878793          	addi	a5,a5,-1128 # 8000b558 <HEAP_END_ADDR>
    800059c8:	0007b783          	ld	a5,0(a5)
    800059cc:	40e787b3          	sub	a5,a5,a4
    800059d0:	fc078793          	addi	a5,a5,-64
    800059d4:	00f73823          	sd	a5,16(a4)
}
    800059d8:	00813403          	ld	s0,8(sp)
    800059dc:	01010113          	addi	sp,sp,16
    800059e0:	00008067          	ret

00000000800059e4 <_ZN15MemoryAllocator9mem_allocEm>:

void *MemoryAllocator::mem_alloc(size_t sz)
{
    800059e4:	ff010113          	addi	sp,sp,-16
    800059e8:	00813423          	sd	s0,8(sp)
    800059ec:	01010413          	addi	s0,sp,16

    size_t size = sz * MEM_BLOCK_SIZE;
    800059f0:	00651713          	slli	a4,a0,0x6
    if (size <= 0)
    800059f4:	0c070e63          	beqz	a4,80005ad0 <_ZN15MemoryAllocator9mem_allocEm+0xec>
        return nullptr;

    FreeMem *curr = fmem_head;
    800059f8:	00006797          	auipc	a5,0x6
    800059fc:	c2878793          	addi	a5,a5,-984 # 8000b620 <_ZN15MemoryAllocator9fmem_headE>
    80005a00:	0007b683          	ld	a3,0(a5)

    for (curr = fmem_head; curr && curr->size < size; curr = curr->next)
    80005a04:	00068513          	mv	a0,a3
    80005a08:	00050a63          	beqz	a0,80005a1c <_ZN15MemoryAllocator9mem_allocEm+0x38>
    80005a0c:	01053783          	ld	a5,16(a0)
    80005a10:	00e7f663          	bgeu	a5,a4,80005a1c <_ZN15MemoryAllocator9mem_allocEm+0x38>
    80005a14:	00053503          	ld	a0,0(a0)
    80005a18:	ff1ff06f          	j	80005a08 <_ZN15MemoryAllocator9mem_allocEm+0x24>
        ; // search for the block big enough

    if (!curr)
    80005a1c:	06050463          	beqz	a0,80005a84 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        return nullptr; // not enough free memory

    if (curr->size == size)
    80005a20:	01053783          	ld	a5,16(a0)
    80005a24:	06e78663          	beq	a5,a4,80005a90 <_ZN15MemoryAllocator9mem_allocEm+0xac>
            curr->next->prev = curr->prev;
    }
    else
    {
        // Make a new free segment
        FreeMem *free = (FreeMem *)((char *)curr + size + HEADER_SIZE);
    80005a28:	04070793          	addi	a5,a4,64
    80005a2c:	00f507b3          	add	a5,a0,a5
        free->next = curr->next;
    80005a30:	00053683          	ld	a3,0(a0)
    80005a34:	00d7b023          	sd	a3,0(a5)
        free->prev = curr->prev;
    80005a38:	00853683          	ld	a3,8(a0)
    80005a3c:	00d7b423          	sd	a3,8(a5)
        free->size = curr->size - size - MEM_BLOCK_SIZE;
    80005a40:	01053683          	ld	a3,16(a0)
    80005a44:	40e686b3          	sub	a3,a3,a4
    80005a48:	fc068693          	addi	a3,a3,-64
    80005a4c:	00d7b823          	sd	a3,16(a5)

        // Update the free list - remove curr
        if (curr == fmem_head)
    80005a50:	00006697          	auipc	a3,0x6
    80005a54:	bd068693          	addi	a3,a3,-1072 # 8000b620 <_ZN15MemoryAllocator9fmem_headE>
    80005a58:	0006b683          	ld	a3,0(a3)
    80005a5c:	06a68463          	beq	a3,a0,80005ac4 <_ZN15MemoryAllocator9mem_allocEm+0xe0>
            fmem_head = free;
        else
            curr->prev->next = free;
    80005a60:	00853683          	ld	a3,8(a0)
    80005a64:	00f6b023          	sd	a5,0(a3)
        if (curr->next)
    80005a68:	00053683          	ld	a3,0(a0)
    80005a6c:	00068463          	beqz	a3,80005a74 <_ZN15MemoryAllocator9mem_allocEm+0x90>
            curr->next->prev = free;
    80005a70:	00f6b423          	sd	a5,8(a3)
    }
    curr->prev = nullptr;
    80005a74:	00053423          	sd	zero,8(a0)
    curr->next = nullptr;
    80005a78:	00053023          	sd	zero,0(a0)
    curr->size = size;
    80005a7c:	00e53823          	sd	a4,16(a0)
	
    return (void *)((char *)curr + MEM_BLOCK_SIZE);
    80005a80:	04050513          	addi	a0,a0,64
}
    80005a84:	00813403          	ld	s0,8(sp)
    80005a88:	01010113          	addi	sp,sp,16
    80005a8c:	00008067          	ret
        if (curr != fmem_head)
    80005a90:	02d50263          	beq	a0,a3,80005ab4 <_ZN15MemoryAllocator9mem_allocEm+0xd0>
            curr->prev->next = curr->next;
    80005a94:	00853783          	ld	a5,8(a0)
    80005a98:	00053683          	ld	a3,0(a0)
    80005a9c:	00d7b023          	sd	a3,0(a5)
        if (curr->next)
    80005aa0:	00053783          	ld	a5,0(a0)
    80005aa4:	fc0788e3          	beqz	a5,80005a74 <_ZN15MemoryAllocator9mem_allocEm+0x90>
            curr->next->prev = curr->prev;
    80005aa8:	00853683          	ld	a3,8(a0)
    80005aac:	00d7b423          	sd	a3,8(a5)
    80005ab0:	fc5ff06f          	j	80005a74 <_ZN15MemoryAllocator9mem_allocEm+0x90>
            fmem_head = curr->next; // nullptr - !!!
    80005ab4:	00053783          	ld	a5,0(a0)
    80005ab8:	00006697          	auipc	a3,0x6
    80005abc:	b6f6b423          	sd	a5,-1176(a3) # 8000b620 <_ZN15MemoryAllocator9fmem_headE>
    80005ac0:	fe1ff06f          	j	80005aa0 <_ZN15MemoryAllocator9mem_allocEm+0xbc>
            fmem_head = free;
    80005ac4:	00006697          	auipc	a3,0x6
    80005ac8:	b4f6be23          	sd	a5,-1188(a3) # 8000b620 <_ZN15MemoryAllocator9fmem_headE>
    80005acc:	f9dff06f          	j	80005a68 <_ZN15MemoryAllocator9mem_allocEm+0x84>
        return nullptr;
    80005ad0:	00000513          	li	a0,0
    80005ad4:	fb1ff06f          	j	80005a84 <_ZN15MemoryAllocator9mem_allocEm+0xa0>

0000000080005ad8 <_ZN15MemoryAllocator9tryToJoinEP7FreeMem>:

int MemoryAllocator::tryToJoin(FreeMem *curr)
{
    80005ad8:	ff010113          	addi	sp,sp,-16
    80005adc:	00813423          	sd	s0,8(sp)
    80005ae0:	01010413          	addi	s0,sp,16
    if (!curr)
    80005ae4:	04050a63          	beqz	a0,80005b38 <_ZN15MemoryAllocator9tryToJoinEP7FreeMem+0x60>
        return 0;
    if (curr->next && (char *)curr + curr->size + HEADER_SIZE == (char *)curr->next)
    80005ae8:	00053783          	ld	a5,0(a0)
    80005aec:	04078a63          	beqz	a5,80005b40 <_ZN15MemoryAllocator9tryToJoinEP7FreeMem+0x68>
    80005af0:	01053683          	ld	a3,16(a0)
    80005af4:	04068713          	addi	a4,a3,64
    80005af8:	00e50733          	add	a4,a0,a4
    80005afc:	00e78a63          	beq	a5,a4,80005b10 <_ZN15MemoryAllocator9tryToJoinEP7FreeMem+0x38>
        if (curr->next)
            curr->next->prev = curr;
        return 1;
    }
    else
        return 0;
    80005b00:	00000513          	li	a0,0
}
    80005b04:	00813403          	ld	s0,8(sp)
    80005b08:	01010113          	addi	sp,sp,16
    80005b0c:	00008067          	ret
        curr->size += curr->next->size + HEADER_SIZE;
    80005b10:	0107b703          	ld	a4,16(a5)
    80005b14:	00e686b3          	add	a3,a3,a4
    80005b18:	04068693          	addi	a3,a3,64
    80005b1c:	00d53823          	sd	a3,16(a0)
        curr->next = curr->next->next;
    80005b20:	0007b783          	ld	a5,0(a5)
    80005b24:	00f53023          	sd	a5,0(a0)
        if (curr->next)
    80005b28:	00078463          	beqz	a5,80005b30 <_ZN15MemoryAllocator9tryToJoinEP7FreeMem+0x58>
            curr->next->prev = curr;
    80005b2c:	00a7b423          	sd	a0,8(a5)
        return 1;
    80005b30:	00100513          	li	a0,1
    80005b34:	fd1ff06f          	j	80005b04 <_ZN15MemoryAllocator9tryToJoinEP7FreeMem+0x2c>
        return 0;
    80005b38:	00000513          	li	a0,0
    80005b3c:	fc9ff06f          	j	80005b04 <_ZN15MemoryAllocator9tryToJoinEP7FreeMem+0x2c>
        return 0;
    80005b40:	00000513          	li	a0,0
    80005b44:	fc1ff06f          	j	80005b04 <_ZN15MemoryAllocator9tryToJoinEP7FreeMem+0x2c>

0000000080005b48 <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *addr)
{
    if (addr < HEAP_START_ADDR || addr >= HEAP_END_ADDR || addr == nullptr)
    80005b48:	00006797          	auipc	a5,0x6
    80005b4c:	a1878793          	addi	a5,a5,-1512 # 8000b560 <HEAP_START_ADDR>
    80005b50:	0007b783          	ld	a5,0(a5)
    80005b54:	0cf56863          	bltu	a0,a5,80005c24 <_ZN15MemoryAllocator8mem_freeEPv+0xdc>
    80005b58:	00006797          	auipc	a5,0x6
    80005b5c:	a0078793          	addi	a5,a5,-1536 # 8000b558 <HEAP_END_ADDR>
    80005b60:	0007b783          	ld	a5,0(a5)
    80005b64:	0cf57463          	bgeu	a0,a5,80005c2c <_ZN15MemoryAllocator8mem_freeEPv+0xe4>
    80005b68:	0c050663          	beqz	a0,80005c34 <_ZN15MemoryAllocator8mem_freeEPv+0xec>
{
    80005b6c:	fe010113          	addi	sp,sp,-32
    80005b70:	00113c23          	sd	ra,24(sp)
    80005b74:	00813823          	sd	s0,16(sp)
    80005b78:	00913423          	sd	s1,8(sp)
    80005b7c:	02010413          	addi	s0,sp,32
        return -1;
    FreeMem *curr = nullptr;
    if (!fmem_head || addr < (char *)fmem_head)
    80005b80:	00006797          	auipc	a5,0x6
    80005b84:	aa078793          	addi	a5,a5,-1376 # 8000b620 <_ZN15MemoryAllocator9fmem_headE>
    80005b88:	0007b483          	ld	s1,0(a5)
    80005b8c:	00048663          	beqz	s1,80005b98 <_ZN15MemoryAllocator8mem_freeEPv+0x50>
    80005b90:	06957263          	bgeu	a0,s1,80005bf4 <_ZN15MemoryAllocator8mem_freeEPv+0xac>
        curr = nullptr;
    80005b94:	00000493          	li	s1,0
    else
        for (curr = fmem_head; curr->next != nullptr && addr > (char *)(curr->next); curr = curr->next)
            ;

    FreeMem *newSeg = (FreeMem *)((char *)addr - MEM_BLOCK_SIZE);
    80005b98:	fc050793          	addi	a5,a0,-64
    newSeg->prev = curr;
    80005b9c:	fc953423          	sd	s1,-56(a0)
    if (curr)
    80005ba0:	06048263          	beqz	s1,80005c04 <_ZN15MemoryAllocator8mem_freeEPv+0xbc>
        newSeg->next = curr->next;
    80005ba4:	0004b703          	ld	a4,0(s1)
    80005ba8:	fce53023          	sd	a4,-64(a0)
    else
        newSeg->next = fmem_head;
    if (newSeg->next)
    80005bac:	fc053703          	ld	a4,-64(a0)
    80005bb0:	00070463          	beqz	a4,80005bb8 <_ZN15MemoryAllocator8mem_freeEPv+0x70>
        newSeg->next->prev = newSeg;
    80005bb4:	00f73423          	sd	a5,8(a4)
    if (curr)
    80005bb8:	06048063          	beqz	s1,80005c18 <_ZN15MemoryAllocator8mem_freeEPv+0xd0>
        curr->next = newSeg;
    80005bbc:	00f4b023          	sd	a5,0(s1)
    else
        fmem_head = newSeg;

    tryToJoin(newSeg);
    80005bc0:	00078513          	mv	a0,a5
    80005bc4:	00000097          	auipc	ra,0x0
    80005bc8:	f14080e7          	jalr	-236(ra) # 80005ad8 <_ZN15MemoryAllocator9tryToJoinEP7FreeMem>
    tryToJoin(curr);
    80005bcc:	00048513          	mv	a0,s1
    80005bd0:	00000097          	auipc	ra,0x0
    80005bd4:	f08080e7          	jalr	-248(ra) # 80005ad8 <_ZN15MemoryAllocator9tryToJoinEP7FreeMem>
    return 0;
    80005bd8:	00000513          	li	a0,0
}
    80005bdc:	01813083          	ld	ra,24(sp)
    80005be0:	01013403          	ld	s0,16(sp)
    80005be4:	00813483          	ld	s1,8(sp)
    80005be8:	02010113          	addi	sp,sp,32
    80005bec:	00008067          	ret
        for (curr = fmem_head; curr->next != nullptr && addr > (char *)(curr->next); curr = curr->next)
    80005bf0:	00078493          	mv	s1,a5
    80005bf4:	0004b783          	ld	a5,0(s1)
    80005bf8:	fa0780e3          	beqz	a5,80005b98 <_ZN15MemoryAllocator8mem_freeEPv+0x50>
    80005bfc:	fea7eae3          	bltu	a5,a0,80005bf0 <_ZN15MemoryAllocator8mem_freeEPv+0xa8>
    80005c00:	f99ff06f          	j	80005b98 <_ZN15MemoryAllocator8mem_freeEPv+0x50>
        newSeg->next = fmem_head;
    80005c04:	00006717          	auipc	a4,0x6
    80005c08:	a1c70713          	addi	a4,a4,-1508 # 8000b620 <_ZN15MemoryAllocator9fmem_headE>
    80005c0c:	00073703          	ld	a4,0(a4)
    80005c10:	fce53023          	sd	a4,-64(a0)
    80005c14:	f99ff06f          	j	80005bac <_ZN15MemoryAllocator8mem_freeEPv+0x64>
        fmem_head = newSeg;
    80005c18:	00006717          	auipc	a4,0x6
    80005c1c:	a0f73423          	sd	a5,-1528(a4) # 8000b620 <_ZN15MemoryAllocator9fmem_headE>
    80005c20:	fa1ff06f          	j	80005bc0 <_ZN15MemoryAllocator8mem_freeEPv+0x78>
        return -1;
    80005c24:	fff00513          	li	a0,-1
    80005c28:	00008067          	ret
    80005c2c:	fff00513          	li	a0,-1
    80005c30:	00008067          	ret
    80005c34:	fff00513          	li	a0,-1
}
    80005c38:	00008067          	ret

0000000080005c3c <_Z9mem_allocm>:
#include "../h/syscall_c.hpp"
#include "../h/operation_codes.hpp"

void *mem_alloc(size_t size)
{
    if (!size)
    80005c3c:	04050863          	beqz	a0,80005c8c <_Z9mem_allocm+0x50>
{
    80005c40:	fe010113          	addi	sp,sp,-32
    80005c44:	00813c23          	sd	s0,24(sp)
    80005c48:	02010413          	addi	s0,sp,32
        return nullptr;
    size_t numBlocks = (size % MEM_BLOCK_SIZE == 0) ? size / MEM_BLOCK_SIZE : size / MEM_BLOCK_SIZE + 1;
    80005c4c:	03f57793          	andi	a5,a0,63
    80005c50:	02079863          	bnez	a5,80005c80 <_Z9mem_allocm+0x44>
    80005c54:	00655513          	srli	a0,a0,0x6
    __asm__ volatile("mv a2, %0" : : "r"(numBlocks));
    80005c58:	00050613          	mv	a2,a0
    __asm__ volatile("mv a0, %0" : : "r"(MEM_ALLOC));
    80005c5c:	00100793          	li	a5,1
    80005c60:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80005c64:	00000073          	ecall

    volatile uint64 retaddr;
    __asm__ volatile("mv %0, a0" : "=r"(retaddr));
    80005c68:	00050793          	mv	a5,a0
    80005c6c:	fef43423          	sd	a5,-24(s0)
    return (void *)retaddr;
    80005c70:	fe843503          	ld	a0,-24(s0)
}
    80005c74:	01813403          	ld	s0,24(sp)
    80005c78:	02010113          	addi	sp,sp,32
    80005c7c:	00008067          	ret
    size_t numBlocks = (size % MEM_BLOCK_SIZE == 0) ? size / MEM_BLOCK_SIZE : size / MEM_BLOCK_SIZE + 1;
    80005c80:	00655513          	srli	a0,a0,0x6
    80005c84:	00150513          	addi	a0,a0,1
    80005c88:	fd1ff06f          	j	80005c58 <_Z9mem_allocm+0x1c>
        return nullptr;
    80005c8c:	00000513          	li	a0,0
}
    80005c90:	00008067          	ret

0000000080005c94 <_Z8mem_freePv>:

int mem_free(void *addr)
{
    if (!addr)
    80005c94:	02050e63          	beqz	a0,80005cd0 <_Z8mem_freePv+0x3c>
{
    80005c98:	fe010113          	addi	sp,sp,-32
    80005c9c:	00813c23          	sd	s0,24(sp)
    80005ca0:	02010413          	addi	s0,sp,32
        return -1;
    __asm__ volatile("mv a2, %0" : : "r"(addr));
    80005ca4:	00050613          	mv	a2,a0
    __asm__ volatile("mv a0, %0" : : "r"(MEM_FREE));
    80005ca8:	00200793          	li	a5,2
    80005cac:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80005cb0:	00000073          	ecall

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    80005cb4:	00050793          	mv	a5,a0
    80005cb8:	fef42623          	sw	a5,-20(s0)
    return status;
    80005cbc:	fec42503          	lw	a0,-20(s0)
    80005cc0:	0005051b          	sext.w	a0,a0
}
    80005cc4:	01813403          	ld	s0,24(sp)
    80005cc8:	02010113          	addi	sp,sp,32
    80005ccc:	00008067          	ret
        return -1;
    80005cd0:	fff00513          	li	a0,-1
}
    80005cd4:	00008067          	ret

0000000080005cd8 <_Z13thread_createPP3TCBPFvPvES2_>:

int thread_create(thread_t *handle, void (*start_routine)(void*), void *arg)
{
    80005cd8:	fc010113          	addi	sp,sp,-64
    80005cdc:	02113c23          	sd	ra,56(sp)
    80005ce0:	02813823          	sd	s0,48(sp)
    80005ce4:	02913423          	sd	s1,40(sp)
    80005ce8:	03213023          	sd	s2,32(sp)
    80005cec:	01313c23          	sd	s3,24(sp)
    80005cf0:	04010413          	addi	s0,sp,64
    80005cf4:	00050493          	mv	s1,a0
    80005cf8:	00058913          	mv	s2,a1
    80005cfc:	00060993          	mv	s3,a2

    uint64 *stack_space = (uint64 *)mem_alloc(DEFAULT_STACK_SIZE);
    80005d00:	00001537          	lui	a0,0x1
    80005d04:	00000097          	auipc	ra,0x0
    80005d08:	f38080e7          	jalr	-200(ra) # 80005c3c <_Z9mem_allocm>

    if (!stack_space)
    80005d0c:	04050663          	beqz	a0,80005d58 <_Z13thread_createPP3TCBPFvPvES2_+0x80>
    {
        return -1;
    }

    __asm__ volatile("mv a4, %0" : : "r"(stack_space));
    80005d10:	00050713          	mv	a4,a0
    __asm__ volatile("mv a3, %0" : : "r"(arg));
    80005d14:	00098693          	mv	a3,s3
    __asm__ volatile("mv a2, %0" : : "r"(start_routine));
    80005d18:	00090613          	mv	a2,s2
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80005d1c:	00048593          	mv	a1,s1
    __asm__ volatile("mv a0, %0" : : "r"(THREAD_CREATE));
    80005d20:	01100793          	li	a5,17
    80005d24:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80005d28:	00000073          	ecall

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    80005d2c:	00050793          	mv	a5,a0
    80005d30:	fcf42623          	sw	a5,-52(s0)
    return status;
    80005d34:	fcc42503          	lw	a0,-52(s0)
    80005d38:	0005051b          	sext.w	a0,a0
}
    80005d3c:	03813083          	ld	ra,56(sp)
    80005d40:	03013403          	ld	s0,48(sp)
    80005d44:	02813483          	ld	s1,40(sp)
    80005d48:	02013903          	ld	s2,32(sp)
    80005d4c:	01813983          	ld	s3,24(sp)
    80005d50:	04010113          	addi	sp,sp,64
    80005d54:	00008067          	ret
        return -1;
    80005d58:	fff00513          	li	a0,-1
    80005d5c:	fe1ff06f          	j	80005d3c <_Z13thread_createPP3TCBPFvPvES2_+0x64>

0000000080005d60 <_Z11thread_exitv>:

int thread_exit()
{
    80005d60:	ff010113          	addi	sp,sp,-16
    80005d64:	00813423          	sd	s0,8(sp)
    80005d68:	01010413          	addi	s0,sp,16
    __asm__ volatile("mv a0, %0" : : "r"(THREAD_EXIT));
    80005d6c:	01200793          	li	a5,18
    80005d70:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80005d74:	00000073          	ecall

    return 0;
}
    80005d78:	00000513          	li	a0,0
    80005d7c:	00813403          	ld	s0,8(sp)
    80005d80:	01010113          	addi	sp,sp,16
    80005d84:	00008067          	ret

0000000080005d88 <_Z15thread_dispatchv>:

void thread_dispatch()
{
    80005d88:	ff010113          	addi	sp,sp,-16
    80005d8c:	00813423          	sd	s0,8(sp)
    80005d90:	01010413          	addi	s0,sp,16
    __asm__ volatile("mv a0, %0" : : "r"(THREAD_DISPATCH));
    80005d94:	01300793          	li	a5,19
    80005d98:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80005d9c:	00000073          	ecall
}
    80005da0:	00813403          	ld	s0,8(sp)
    80005da4:	01010113          	addi	sp,sp,16
    80005da8:	00008067          	ret

0000000080005dac <_Z10time_sleepm>:

int time_sleep (time_t time){
    80005dac:	ff010113          	addi	sp,sp,-16
    80005db0:	00813423          	sd	s0,8(sp)
    80005db4:	01010413          	addi	s0,sp,16
    __asm__ volatile("mv a1, %0" : : "r"(time));
    80005db8:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(THREAD_SLEEP));
    80005dbc:	01400793          	li	a5,20
    80005dc0:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80005dc4:	00000073          	ecall

    return 0;
}
    80005dc8:	00000513          	li	a0,0
    80005dcc:	00813403          	ld	s0,8(sp)
    80005dd0:	01010113          	addi	sp,sp,16
    80005dd4:	00008067          	ret

0000000080005dd8 <_Z8sem_openPP5mySemj>:

int sem_open(sem_t* handle, unsigned init){
    80005dd8:	fe010113          	addi	sp,sp,-32
    80005ddc:	00813c23          	sd	s0,24(sp)
    80005de0:	02010413          	addi	s0,sp,32
    __asm__ volatile("mv a2, %0" : : "r"(init));
    80005de4:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80005de8:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(SEM_OPEN));
    80005dec:	02100793          	li	a5,33
    80005df0:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80005df4:	00000073          	ecall

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    80005df8:	00050793          	mv	a5,a0
    80005dfc:	fef42623          	sw	a5,-20(s0)
    return status;
    80005e00:	fec42503          	lw	a0,-20(s0)
}
    80005e04:	0005051b          	sext.w	a0,a0
    80005e08:	01813403          	ld	s0,24(sp)
    80005e0c:	02010113          	addi	sp,sp,32
    80005e10:	00008067          	ret

0000000080005e14 <_Z9sem_closeP5mySem>:

int sem_close(sem_t handle){
    80005e14:	fe010113          	addi	sp,sp,-32
    80005e18:	00813c23          	sd	s0,24(sp)
    80005e1c:	02010413          	addi	s0,sp,32
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80005e20:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(SEM_CLOSE));
    80005e24:	02200793          	li	a5,34
    80005e28:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80005e2c:	00000073          	ecall

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    80005e30:	00050793          	mv	a5,a0
    80005e34:	fef42623          	sw	a5,-20(s0)
    return status;
    80005e38:	fec42503          	lw	a0,-20(s0)
}
    80005e3c:	0005051b          	sext.w	a0,a0
    80005e40:	01813403          	ld	s0,24(sp)
    80005e44:	02010113          	addi	sp,sp,32
    80005e48:	00008067          	ret

0000000080005e4c <_Z8sem_waitP5mySem>:

int sem_wait(sem_t id){
    80005e4c:	fe010113          	addi	sp,sp,-32
    80005e50:	00813c23          	sd	s0,24(sp)
    80005e54:	02010413          	addi	s0,sp,32
    __asm__ volatile("mv a1, %0" : : "r"(id));
    80005e58:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(SEM_WAIT));
    80005e5c:	02300793          	li	a5,35
    80005e60:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80005e64:	00000073          	ecall

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    80005e68:	00050793          	mv	a5,a0
    80005e6c:	fef42623          	sw	a5,-20(s0)
    return status;
    80005e70:	fec42503          	lw	a0,-20(s0)
}
    80005e74:	0005051b          	sext.w	a0,a0
    80005e78:	01813403          	ld	s0,24(sp)
    80005e7c:	02010113          	addi	sp,sp,32
    80005e80:	00008067          	ret

0000000080005e84 <_Z10sem_signalP5mySem>:

int sem_signal (sem_t id){
    80005e84:	fe010113          	addi	sp,sp,-32
    80005e88:	00813c23          	sd	s0,24(sp)
    80005e8c:	02010413          	addi	s0,sp,32
    __asm__ volatile("mv a1, %0" : : "r"(id));
    80005e90:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(SEM_SIGNAL));
    80005e94:	02400793          	li	a5,36
    80005e98:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80005e9c:	00000073          	ecall

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    80005ea0:	00050793          	mv	a5,a0
    80005ea4:	fef42623          	sw	a5,-20(s0)
    return status;
    80005ea8:	fec42503          	lw	a0,-20(s0)
}
    80005eac:	0005051b          	sext.w	a0,a0
    80005eb0:	01813403          	ld	s0,24(sp)
    80005eb4:	02010113          	addi	sp,sp,32
    80005eb8:	00008067          	ret

0000000080005ebc <_Z11sem_trywaitP5mySem>:

int sem_trywait(sem_t id){
    80005ebc:	fe010113          	addi	sp,sp,-32
    80005ec0:	00813c23          	sd	s0,24(sp)
    80005ec4:	02010413          	addi	s0,sp,32
    __asm__ volatile("mv a1, %0" : : "r"(id));
    80005ec8:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(SEM_TRYWAIT));
    80005ecc:	02600793          	li	a5,38
    80005ed0:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80005ed4:	00000073          	ecall

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    80005ed8:	00050793          	mv	a5,a0
    80005edc:	fef42623          	sw	a5,-20(s0)
    return status;
    80005ee0:	fec42503          	lw	a0,-20(s0)
}
    80005ee4:	0005051b          	sext.w	a0,a0
    80005ee8:	01813403          	ld	s0,24(sp)
    80005eec:	02010113          	addi	sp,sp,32
    80005ef0:	00008067          	ret

0000000080005ef4 <_Z13sem_timedwaitP5mySemm>:

int sem_timedwait(sem_t id, time_t time) {
    80005ef4:	fe010113          	addi	sp,sp,-32
    80005ef8:	00813c23          	sd	s0,24(sp)
    80005efc:	02010413          	addi	s0,sp,32
    __asm__ volatile("mv a2, %0" : : "r"(id));
    80005f00:	00050613          	mv	a2,a0
    __asm__ volatile("mv a1, %0" : : "r"(time));
    80005f04:	00058593          	mv	a1,a1
    __asm__ volatile("mv a0, %0" : : "r"(SEM_TIMEDWAIT));
    80005f08:	02500793          	li	a5,37
    80005f0c:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80005f10:	00000073          	ecall

    volatile int status;
    __asm__ volatile("mv %0, a0" : "=r"(status));
    80005f14:	00050793          	mv	a5,a0
    80005f18:	fef42623          	sw	a5,-20(s0)
    return status;
    80005f1c:	fec42503          	lw	a0,-20(s0)
}
    80005f20:	0005051b          	sext.w	a0,a0
    80005f24:	01813403          	ld	s0,24(sp)
    80005f28:	02010113          	addi	sp,sp,32
    80005f2c:	00008067          	ret

0000000080005f30 <_Z4getcv>:

char getc(){
    80005f30:	fe010113          	addi	sp,sp,-32
    80005f34:	00813c23          	sd	s0,24(sp)
    80005f38:	02010413          	addi	s0,sp,32
    __asm__ volatile("mv a0, %0" : : "r"(GETC));
    80005f3c:	04100793          	li	a5,65
    80005f40:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80005f44:	00000073          	ecall

    volatile char character;

    __asm__ volatile("mv %0, a0" : "=r"(character));
    80005f48:	00050793          	mv	a5,a0
    80005f4c:	fef407a3          	sb	a5,-17(s0)
    return character;
    80005f50:	fef44503          	lbu	a0,-17(s0)
}
    80005f54:	01813403          	ld	s0,24(sp)
    80005f58:	02010113          	addi	sp,sp,32
    80005f5c:	00008067          	ret

0000000080005f60 <_Z4putcc>:

void putc(char c){
    80005f60:	ff010113          	addi	sp,sp,-16
    80005f64:	00813423          	sd	s0,8(sp)
    80005f68:	01010413          	addi	s0,sp,16
    __asm__ volatile("mv a1, %0" : : "r"(c));
    80005f6c:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(PUTC));
    80005f70:	04200793          	li	a5,66
    80005f74:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80005f78:	00000073          	ecall
}
    80005f7c:	00813403          	ld	s0,8(sp)
    80005f80:	01010113          	addi	sp,sp,16
    80005f84:	00008067          	ret

0000000080005f88 <_Z41__static_initialization_and_destruction_0ii>:
            mySem* sem = allTimedSems.getData();
            if(sem) sem->checkWaitingList();
            if(allTimedSems.movePointer() == -1) break;
        }
    }
}
    80005f88:	ff010113          	addi	sp,sp,-16
    80005f8c:	00813423          	sd	s0,8(sp)
    80005f90:	01010413          	addi	s0,sp,16
    80005f94:	00100793          	li	a5,1
    80005f98:	00f50863          	beq	a0,a5,80005fa8 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80005f9c:	00813403          	ld	s0,8(sp)
    80005fa0:	01010113          	addi	sp,sp,16
    80005fa4:	00008067          	ret
    80005fa8:	000107b7          	lui	a5,0x10
    80005fac:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005fb0:	fef596e3          	bne	a1,a5,80005f9c <_Z41__static_initialization_and_destruction_0ii+0x14>
    80005fb4:	00005797          	auipc	a5,0x5
    80005fb8:	6cc78793          	addi	a5,a5,1740 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    80005fbc:	0007b023          	sd	zero,0(a5)
    80005fc0:	0007b423          	sd	zero,8(a5)
    80005fc4:	0007b823          	sd	zero,16(a5)
    80005fc8:	0007bc23          	sd	zero,24(a5)
    80005fcc:	0207b023          	sd	zero,32(a5)
    80005fd0:	0207b423          	sd	zero,40(a5)
    80005fd4:	fc9ff06f          	j	80005f9c <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080005fd8 <_ZN5mySem5closeEv>:
void mySem::close() {
    80005fd8:	fe010113          	addi	sp,sp,-32
    80005fdc:	00113c23          	sd	ra,24(sp)
    80005fe0:	00813823          	sd	s0,16(sp)
    80005fe4:	00913423          	sd	s1,8(sp)
    80005fe8:	01213023          	sd	s2,0(sp)
    80005fec:	02010413          	addi	s0,sp,32
    80005ff0:	00050913          	mv	s2,a0
    80005ff4:	0240006f          	j	80006018 <_ZN5mySem5closeEv+0x40>
            tail = 0;
    80005ff8:	00093823          	sd	zero,16(s2)
        T *ret = elem->data;
    80005ffc:	00053483          	ld	s1,0(a0) # 1000 <_entry-0x7ffff000>
        MemoryAllocator::mem_free(elem);
    80006000:	00000097          	auipc	ra,0x0
    80006004:	b48080e7          	jalr	-1208(ra) # 80005b48 <_ZN15MemoryAllocator8mem_freeEPv>
    while((thread = blocked.removeFirst()) != nullptr){
    80006008:	02048463          	beqz	s1,80006030 <_ZN5mySem5closeEv+0x58>
        Scheduler::put(thread);
    8000600c:	00048513          	mv	a0,s1
    80006010:	fffff097          	auipc	ra,0xfffff
    80006014:	490080e7          	jalr	1168(ra) # 800054a0 <_ZN9Scheduler3putEP3TCB>
        if (!head)
    80006018:	00893503          	ld	a0,8(s2)
    8000601c:	00050a63          	beqz	a0,80006030 <_ZN5mySem5closeEv+0x58>
        head = head->next;
    80006020:	00853783          	ld	a5,8(a0)
    80006024:	00f93423          	sd	a5,8(s2)
        if (!head)
    80006028:	fc079ae3          	bnez	a5,80005ffc <_ZN5mySem5closeEv+0x24>
    8000602c:	fcdff06f          	j	80005ff8 <_ZN5mySem5closeEv+0x20>
    closed = true;
    80006030:	00100793          	li	a5,1
    80006034:	00f90223          	sb	a5,4(s2)
}
    80006038:	01813083          	ld	ra,24(sp)
    8000603c:	01013403          	ld	s0,16(sp)
    80006040:	00813483          	ld	s1,8(sp)
    80006044:	00013903          	ld	s2,0(sp)
    80006048:	02010113          	addi	sp,sp,32
    8000604c:	00008067          	ret

0000000080006050 <_ZN5mySem5blockEv>:
void mySem::block() {
    80006050:	fe010113          	addi	sp,sp,-32
    80006054:	00113c23          	sd	ra,24(sp)
    80006058:	00813823          	sd	s0,16(sp)
    8000605c:	00913423          	sd	s1,8(sp)
    80006060:	01213023          	sd	s2,0(sp)
    80006064:	02010413          	addi	s0,sp,32
    80006068:	00050493          	mv	s1,a0
    TCB* old = TCB::running;
    8000606c:	00005797          	auipc	a5,0x5
    80006070:	5ac78793          	addi	a5,a5,1452 # 8000b618 <_ZN3TCB7runningE>
    80006074:	0007b903          	ld	s2,0(a5)
        Elem *elem = (Elem *)MemoryAllocator::mem_alloc(numBlocks);
    80006078:	00100513          	li	a0,1
    8000607c:	00000097          	auipc	ra,0x0
    80006080:	968080e7          	jalr	-1688(ra) # 800059e4 <_ZN15MemoryAllocator9mem_allocEm>
        elem->data = data;
    80006084:	01253023          	sd	s2,0(a0)
        elem->next = 0;
    80006088:	00053423          	sd	zero,8(a0)
        if (tail)
    8000608c:	0104b783          	ld	a5,16(s1)
    80006090:	04078263          	beqz	a5,800060d4 <_ZN5mySem5blockEv+0x84>
            tail->next = elem;
    80006094:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80006098:	00a4b823          	sd	a0,16(s1)
    TCB::running = Scheduler::get();
    8000609c:	fffff097          	auipc	ra,0xfffff
    800060a0:	398080e7          	jalr	920(ra) # 80005434 <_ZN9Scheduler3getEv>
    800060a4:	00005797          	auipc	a5,0x5
    800060a8:	56a7ba23          	sd	a0,1396(a5) # 8000b618 <_ZN3TCB7runningE>
    TCB::contextSwitch(&old->context, &TCB::running->context);
    800060ac:	01850593          	addi	a1,a0,24
    800060b0:	01890513          	addi	a0,s2,24
    800060b4:	ffffb097          	auipc	ra,0xffffb
    800060b8:	07c080e7          	jalr	124(ra) # 80001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    800060bc:	01813083          	ld	ra,24(sp)
    800060c0:	01013403          	ld	s0,16(sp)
    800060c4:	00813483          	ld	s1,8(sp)
    800060c8:	00013903          	ld	s2,0(sp)
    800060cc:	02010113          	addi	sp,sp,32
    800060d0:	00008067          	ret
            head = tail = elem;
    800060d4:	00a4b823          	sd	a0,16(s1)
    800060d8:	00a4b423          	sd	a0,8(s1)
    800060dc:	fc1ff06f          	j	8000609c <_ZN5mySem5blockEv+0x4c>

00000000800060e0 <_ZN5mySem4waitEv>:
    if(--val < 0){
    800060e0:	00052783          	lw	a5,0(a0)
    800060e4:	fff7879b          	addiw	a5,a5,-1
    800060e8:	00f52023          	sw	a5,0(a0)
    800060ec:	02079713          	slli	a4,a5,0x20
    800060f0:	00074463          	bltz	a4,800060f8 <_ZN5mySem4waitEv+0x18>
    800060f4:	00008067          	ret
void mySem::wait() {
    800060f8:	ff010113          	addi	sp,sp,-16
    800060fc:	00113423          	sd	ra,8(sp)
    80006100:	00813023          	sd	s0,0(sp)
    80006104:	01010413          	addi	s0,sp,16
        block();
    80006108:	00000097          	auipc	ra,0x0
    8000610c:	f48080e7          	jalr	-184(ra) # 80006050 <_ZN5mySem5blockEv>
}
    80006110:	00813083          	ld	ra,8(sp)
    80006114:	00013403          	ld	s0,0(sp)
    80006118:	01010113          	addi	sp,sp,16
    8000611c:	00008067          	ret

0000000080006120 <_ZN5mySem7deblockEv>:
void mySem::deblock() {
    80006120:	fe010113          	addi	sp,sp,-32
    80006124:	00113c23          	sd	ra,24(sp)
    80006128:	00813823          	sd	s0,16(sp)
    8000612c:	00913423          	sd	s1,8(sp)
    80006130:	02010413          	addi	s0,sp,32
        if (!head)
    80006134:	00853783          	ld	a5,8(a0)
    80006138:	04078463          	beqz	a5,80006180 <_ZN5mySem7deblockEv+0x60>
        head = head->next;
    8000613c:	0087b703          	ld	a4,8(a5)
    80006140:	00e53423          	sd	a4,8(a0)
        if (!head)
    80006144:	02070a63          	beqz	a4,80006178 <_ZN5mySem7deblockEv+0x58>
        T *ret = elem->data;
    80006148:	0007b483          	ld	s1,0(a5)
        MemoryAllocator::mem_free(elem);
    8000614c:	00078513          	mv	a0,a5
    80006150:	00000097          	auipc	ra,0x0
    80006154:	9f8080e7          	jalr	-1544(ra) # 80005b48 <_ZN15MemoryAllocator8mem_freeEPv>
    Scheduler::put(thread);
    80006158:	00048513          	mv	a0,s1
    8000615c:	fffff097          	auipc	ra,0xfffff
    80006160:	344080e7          	jalr	836(ra) # 800054a0 <_ZN9Scheduler3putEP3TCB>
}
    80006164:	01813083          	ld	ra,24(sp)
    80006168:	01013403          	ld	s0,16(sp)
    8000616c:	00813483          	ld	s1,8(sp)
    80006170:	02010113          	addi	sp,sp,32
    80006174:	00008067          	ret
            tail = 0;
    80006178:	00053823          	sd	zero,16(a0)
    8000617c:	fcdff06f          	j	80006148 <_ZN5mySem7deblockEv+0x28>
            return 0;
    80006180:	00078493          	mv	s1,a5
    80006184:	fd5ff06f          	j	80006158 <_ZN5mySem7deblockEv+0x38>

0000000080006188 <_ZN5mySem6signalEv>:
    if (val++<0)
    80006188:	00052783          	lw	a5,0(a0)
    8000618c:	0017871b          	addiw	a4,a5,1
    80006190:	00e52023          	sw	a4,0(a0)
    80006194:	0007c463          	bltz	a5,8000619c <_ZN5mySem6signalEv+0x14>
    80006198:	00008067          	ret
void mySem::signal() {
    8000619c:	ff010113          	addi	sp,sp,-16
    800061a0:	00113423          	sd	ra,8(sp)
    800061a4:	00813023          	sd	s0,0(sp)
    800061a8:	01010413          	addi	s0,sp,16
        deblock();
    800061ac:	00000097          	auipc	ra,0x0
    800061b0:	f74080e7          	jalr	-140(ra) # 80006120 <_ZN5mySem7deblockEv>
}
    800061b4:	00813083          	ld	ra,8(sp)
    800061b8:	00013403          	ld	s0,0(sp)
    800061bc:	01010113          	addi	sp,sp,16
    800061c0:	00008067          	ret

00000000800061c4 <_ZN5mySem7trywaitEv>:
int mySem::trywait() {
    800061c4:	ff010113          	addi	sp,sp,-16
    800061c8:	00813423          	sd	s0,8(sp)
    800061cc:	01010413          	addi	s0,sp,16
    if (val > 0){
    800061d0:	00052783          	lw	a5,0(a0)
    800061d4:	00f04a63          	bgtz	a5,800061e8 <_ZN5mySem7trywaitEv+0x24>
    return 0;
    800061d8:	00000513          	li	a0,0
}
    800061dc:	00813403          	ld	s0,8(sp)
    800061e0:	01010113          	addi	sp,sp,16
    800061e4:	00008067          	ret
        val--;
    800061e8:	fff7879b          	addiw	a5,a5,-1
    800061ec:	00f52023          	sw	a5,0(a0)
        return 1;
    800061f0:	00100513          	li	a0,1
    800061f4:	fe9ff06f          	j	800061dc <_ZN5mySem7trywaitEv+0x18>

00000000800061f8 <_ZN5mySem16addToWaitingListEm>:
void mySem::addToWaitingList(time_t period) {
    800061f8:	fe010113          	addi	sp,sp,-32
    800061fc:	00113c23          	sd	ra,24(sp)
    80006200:	00813823          	sd	s0,16(sp)
    80006204:	00913423          	sd	s1,8(sp)
    80006208:	01213023          	sd	s2,0(sp)
    8000620c:	02010413          	addi	s0,sp,32
    80006210:	00058913          	mv	s2,a1
    if(!flagAdded) {
    80006214:	02054783          	lbu	a5,32(a0)
    80006218:	08078263          	beqz	a5,8000629c <_ZN5mySem16addToWaitingListEm+0xa4>
    TCB::running->sleepTime = period;
    8000621c:	00005797          	auipc	a5,0x5
    80006220:	3fc78793          	addi	a5,a5,1020 # 8000b618 <_ZN3TCB7runningE>
    80006224:	0007b483          	ld	s1,0(a5)
    80006228:	0324aa23          	sw	s2,52(s1)
        Elem *elem = (Elem *)MemoryAllocator::mem_alloc(numBlocks);
    8000622c:	00100513          	li	a0,1
    80006230:	fffff097          	auipc	ra,0xfffff
    80006234:	7b4080e7          	jalr	1972(ra) # 800059e4 <_ZN15MemoryAllocator9mem_allocEm>
        elem->data = data;
    80006238:	00953023          	sd	s1,0(a0)
        elem->next = 0;
    8000623c:	00053423          	sd	zero,8(a0)
        if (tail)
    80006240:	00005797          	auipc	a5,0x5
    80006244:	44078793          	addi	a5,a5,1088 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    80006248:	0087b783          	ld	a5,8(a5)
    8000624c:	0a078263          	beqz	a5,800062f0 <_ZN5mySem16addToWaitingListEm+0xf8>
            tail->next = elem;
    80006250:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80006254:	00005797          	auipc	a5,0x5
    80006258:	42a7ba23          	sd	a0,1076(a5) # 8000b688 <_ZN5mySem13sleepingOnSemE+0x8>
    TCB* old = TCB::running;
    8000625c:	00005497          	auipc	s1,0x5
    80006260:	3bc48493          	addi	s1,s1,956 # 8000b618 <_ZN3TCB7runningE>
    80006264:	0004b903          	ld	s2,0(s1)
    TCB::running = Scheduler::get();
    80006268:	fffff097          	auipc	ra,0xfffff
    8000626c:	1cc080e7          	jalr	460(ra) # 80005434 <_ZN9Scheduler3getEv>
    80006270:	00a4b023          	sd	a0,0(s1)
    TCB::contextSwitch(&old->context, &TCB::running->context);
    80006274:	01850593          	addi	a1,a0,24
    80006278:	01890513          	addi	a0,s2,24
    8000627c:	ffffb097          	auipc	ra,0xffffb
    80006280:	eb4080e7          	jalr	-332(ra) # 80001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80006284:	01813083          	ld	ra,24(sp)
    80006288:	01013403          	ld	s0,16(sp)
    8000628c:	00813483          	ld	s1,8(sp)
    80006290:	00013903          	ld	s2,0(sp)
    80006294:	02010113          	addi	sp,sp,32
    80006298:	00008067          	ret
    8000629c:	00050493          	mv	s1,a0
        Elem *elem = (Elem *)MemoryAllocator::mem_alloc(numBlocks);
    800062a0:	00100513          	li	a0,1
    800062a4:	fffff097          	auipc	ra,0xfffff
    800062a8:	740080e7          	jalr	1856(ra) # 800059e4 <_ZN15MemoryAllocator9mem_allocEm>
        elem->data = data;
    800062ac:	00953023          	sd	s1,0(a0)
        elem->next = 0;
    800062b0:	00053423          	sd	zero,8(a0)
        if (tail)
    800062b4:	00005797          	auipc	a5,0x5
    800062b8:	3cc78793          	addi	a5,a5,972 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    800062bc:	0207b783          	ld	a5,32(a5)
    800062c0:	00078e63          	beqz	a5,800062dc <_ZN5mySem16addToWaitingListEm+0xe4>
            tail->next = elem;
    800062c4:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800062c8:	00005797          	auipc	a5,0x5
    800062cc:	3ca7bc23          	sd	a0,984(a5) # 8000b6a0 <_ZN5mySem12allTimedSemsE+0x8>
        flagAdded = true;
    800062d0:	00100793          	li	a5,1
    800062d4:	02f48023          	sb	a5,32(s1)
    800062d8:	f45ff06f          	j	8000621c <_ZN5mySem16addToWaitingListEm+0x24>
            head = tail = elem;
    800062dc:	00005797          	auipc	a5,0x5
    800062e0:	3a478793          	addi	a5,a5,932 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    800062e4:	02a7b023          	sd	a0,32(a5)
    800062e8:	00a7bc23          	sd	a0,24(a5)
    800062ec:	fe5ff06f          	j	800062d0 <_ZN5mySem16addToWaitingListEm+0xd8>
    800062f0:	00005797          	auipc	a5,0x5
    800062f4:	39078793          	addi	a5,a5,912 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    800062f8:	00a7b423          	sd	a0,8(a5)
    800062fc:	00a7b023          	sd	a0,0(a5)
    80006300:	f5dff06f          	j	8000625c <_ZN5mySem16addToWaitingListEm+0x64>

0000000080006304 <_ZN5mySem16checkWaitingListEv>:
        if(!head) return -1;
    80006304:	00005797          	auipc	a5,0x5
    80006308:	37c78793          	addi	a5,a5,892 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    8000630c:	0007b783          	ld	a5,0(a5)
    80006310:	16078463          	beqz	a5,80006478 <_ZN5mySem16checkWaitingListEv+0x174>
void mySem::checkWaitingList() {
    80006314:	fe010113          	addi	sp,sp,-32
    80006318:	00113c23          	sd	ra,24(sp)
    8000631c:	00813823          	sd	s0,16(sp)
    80006320:	00913423          	sd	s1,8(sp)
    80006324:	02010413          	addi	s0,sp,32
        pointer = head;
    80006328:	00005717          	auipc	a4,0x5
    8000632c:	36f73423          	sd	a5,872(a4) # 8000b690 <_ZN5mySem13sleepingOnSemE+0x10>
    80006330:	0d80006f          	j	80006408 <_ZN5mySem16checkWaitingListEv+0x104>
        if (!head)
    80006334:	00005797          	auipc	a5,0x5
    80006338:	34c78793          	addi	a5,a5,844 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    8000633c:	0007b503          	ld	a0,0(a5)
    80006340:	08050e63          	beqz	a0,800063dc <_ZN5mySem16checkWaitingListEv+0xd8>
        head = head->next;
    80006344:	00853783          	ld	a5,8(a0)
    80006348:	00005717          	auipc	a4,0x5
    8000634c:	32f73c23          	sd	a5,824(a4) # 8000b680 <_ZN5mySem13sleepingOnSemE>
        if (!head)
    80006350:	00078863          	beqz	a5,80006360 <_ZN5mySem16checkWaitingListEv+0x5c>
        MemoryAllocator::mem_free(elem);
    80006354:	fffff097          	auipc	ra,0xfffff
    80006358:	7f4080e7          	jalr	2036(ra) # 80005b48 <_ZN15MemoryAllocator8mem_freeEPv>
    8000635c:	0800006f          	j	800063dc <_ZN5mySem16checkWaitingListEv+0xd8>
            tail = 0;
    80006360:	00005797          	auipc	a5,0x5
    80006364:	3207b423          	sd	zero,808(a5) # 8000b688 <_ZN5mySem13sleepingOnSemE+0x8>
    80006368:	fedff06f          	j	80006354 <_ZN5mySem16checkWaitingListEv+0x50>
        if (!head)
    8000636c:	00005797          	auipc	a5,0x5
    80006370:	31478793          	addi	a5,a5,788 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    80006374:	0007b783          	ld	a5,0(a5)
    80006378:	06078263          	beqz	a5,800063dc <_ZN5mySem16checkWaitingListEv+0xd8>
        Elem *prev = 0;
    8000637c:	00000693          	li	a3,0
        for (Elem *curr = head; curr && curr != tail; curr = curr->next)
    80006380:	02078063          	beqz	a5,800063a0 <_ZN5mySem16checkWaitingListEv+0x9c>
    80006384:	00005717          	auipc	a4,0x5
    80006388:	2fc70713          	addi	a4,a4,764 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    8000638c:	00873703          	ld	a4,8(a4)
    80006390:	00e78863          	beq	a5,a4,800063a0 <_ZN5mySem16checkWaitingListEv+0x9c>
            prev = curr;
    80006394:	00078693          	mv	a3,a5
        for (Elem *curr = head; curr && curr != tail; curr = curr->next)
    80006398:	0087b783          	ld	a5,8(a5)
    8000639c:	fe5ff06f          	j	80006380 <_ZN5mySem16checkWaitingListEv+0x7c>
        Elem *elem = tail;
    800063a0:	00005797          	auipc	a5,0x5
    800063a4:	2e078793          	addi	a5,a5,736 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    800063a8:	0087b503          	ld	a0,8(a5)
        if (prev)
    800063ac:	00068e63          	beqz	a3,800063c8 <_ZN5mySem16checkWaitingListEv+0xc4>
            prev->next = 0;
    800063b0:	0006b423          	sd	zero,8(a3)
        tail = prev;
    800063b4:	00005797          	auipc	a5,0x5
    800063b8:	2cd7ba23          	sd	a3,724(a5) # 8000b688 <_ZN5mySem13sleepingOnSemE+0x8>
        MemoryAllocator::mem_free(elem);
    800063bc:	fffff097          	auipc	ra,0xfffff
    800063c0:	78c080e7          	jalr	1932(ra) # 80005b48 <_ZN15MemoryAllocator8mem_freeEPv>
    800063c4:	0180006f          	j	800063dc <_ZN5mySem16checkWaitingListEv+0xd8>
            head = 0;
    800063c8:	00005797          	auipc	a5,0x5
    800063cc:	2a07bc23          	sd	zero,696(a5) # 8000b680 <_ZN5mySem13sleepingOnSemE>
    800063d0:	fe5ff06f          	j	800063b4 <_ZN5mySem16checkWaitingListEv+0xb0>
            last->next = pointer->next;
    800063d4:	00873783          	ld	a5,8(a4)
    800063d8:	00f6b423          	sd	a5,8(a3)
                Scheduler::put(thread);
    800063dc:	00048513          	mv	a0,s1
    800063e0:	fffff097          	auipc	ra,0xfffff
    800063e4:	0c0080e7          	jalr	192(ra) # 800054a0 <_ZN9Scheduler3putEP3TCB>
        if(!pointer) return -1;
    800063e8:	00005797          	auipc	a5,0x5
    800063ec:	29878793          	addi	a5,a5,664 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    800063f0:	0107b783          	ld	a5,16(a5)
    800063f4:	06078863          	beqz	a5,80006464 <_ZN5mySem16checkWaitingListEv+0x160>
        pointer = pointer->next;
    800063f8:	0087b783          	ld	a5,8(a5)
    800063fc:	00005717          	auipc	a4,0x5
    80006400:	28f73a23          	sd	a5,660(a4) # 8000b690 <_ZN5mySem13sleepingOnSemE+0x10>
        if(!pointer) return -1;
    80006404:	06078063          	beqz	a5,80006464 <_ZN5mySem16checkWaitingListEv+0x160>
        return pointer->data;
    80006408:	00005797          	auipc	a5,0x5
    8000640c:	27878793          	addi	a5,a5,632 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    80006410:	0107b783          	ld	a5,16(a5)
    80006414:	0007b483          	ld	s1,0(a5)
            thread->sleepTime--;
    80006418:	0344a783          	lw	a5,52(s1)
    8000641c:	fff7879b          	addiw	a5,a5,-1
    80006420:	0007871b          	sext.w	a4,a5
    80006424:	02f4aa23          	sw	a5,52(s1)
            if(thread->sleepTime == 0){
    80006428:	fc0710e3          	bnez	a4,800063e8 <_ZN5mySem16checkWaitingListEv+0xe4>
        if(pointer == head) removeFirst();
    8000642c:	00005797          	auipc	a5,0x5
    80006430:	25478793          	addi	a5,a5,596 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    80006434:	0107b703          	ld	a4,16(a5)
    80006438:	0007b783          	ld	a5,0(a5)
    8000643c:	eef70ce3          	beq	a4,a5,80006334 <_ZN5mySem16checkWaitingListEv+0x30>
        else if(pointer == tail) removeLast();
    80006440:	00005697          	auipc	a3,0x5
    80006444:	24068693          	addi	a3,a3,576 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    80006448:	0086b683          	ld	a3,8(a3)
    8000644c:	f2d700e3          	beq	a4,a3,8000636c <_ZN5mySem16checkWaitingListEv+0x68>
            Elem* last = nullptr;
    80006450:	00000693          	li	a3,0
            while(curr != pointer){ last = curr; curr = curr->next; }
    80006454:	f8f700e3          	beq	a4,a5,800063d4 <_ZN5mySem16checkWaitingListEv+0xd0>
    80006458:	00078693          	mv	a3,a5
    8000645c:	0087b783          	ld	a5,8(a5)
    80006460:	ff5ff06f          	j	80006454 <_ZN5mySem16checkWaitingListEv+0x150>
}
    80006464:	01813083          	ld	ra,24(sp)
    80006468:	01013403          	ld	s0,16(sp)
    8000646c:	00813483          	ld	s1,8(sp)
    80006470:	02010113          	addi	sp,sp,32
    80006474:	00008067          	ret
    80006478:	00008067          	ret

000000008000647c <_ZN5mySem17checkAllTimedSemsEv>:
        if(!head) return -1;
    8000647c:	00005797          	auipc	a5,0x5
    80006480:	20478793          	addi	a5,a5,516 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    80006484:	0187b783          	ld	a5,24(a5)
    80006488:	0a078463          	beqz	a5,80006530 <_ZN5mySem17checkAllTimedSemsEv+0xb4>
        pointer = head;
    8000648c:	00005717          	auipc	a4,0x5
    80006490:	20f73e23          	sd	a5,540(a4) # 8000b6a8 <_ZN5mySem12allTimedSemsE+0x10>
    80006494:	0340006f          	j	800064c8 <_ZN5mySem17checkAllTimedSemsEv+0x4c>
}
    80006498:	00813083          	ld	ra,8(sp)
    8000649c:	00013403          	ld	s0,0(sp)
    800064a0:	01010113          	addi	sp,sp,16
    800064a4:	00008067          	ret
        if(!pointer) return -1;
    800064a8:	00005797          	auipc	a5,0x5
    800064ac:	1d878793          	addi	a5,a5,472 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    800064b0:	0287b783          	ld	a5,40(a5)
    800064b4:	06078e63          	beqz	a5,80006530 <_ZN5mySem17checkAllTimedSemsEv+0xb4>
        pointer = pointer->next;
    800064b8:	0087b783          	ld	a5,8(a5)
    800064bc:	00005717          	auipc	a4,0x5
    800064c0:	1ef73623          	sd	a5,492(a4) # 8000b6a8 <_ZN5mySem12allTimedSemsE+0x10>
        if(!pointer) return -1;
    800064c4:	06078463          	beqz	a5,8000652c <_ZN5mySem17checkAllTimedSemsEv+0xb0>
        return pointer->data;
    800064c8:	00005797          	auipc	a5,0x5
    800064cc:	1b878793          	addi	a5,a5,440 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    800064d0:	0287b783          	ld	a5,40(a5)
    800064d4:	0007b503          	ld	a0,0(a5)
            if(sem) sem->checkWaitingList();
    800064d8:	fc0508e3          	beqz	a0,800064a8 <_ZN5mySem17checkAllTimedSemsEv+0x2c>
void mySem::checkAllTimedSems() {
    800064dc:	ff010113          	addi	sp,sp,-16
    800064e0:	00113423          	sd	ra,8(sp)
    800064e4:	00813023          	sd	s0,0(sp)
    800064e8:	01010413          	addi	s0,sp,16
            if(sem) sem->checkWaitingList();
    800064ec:	00000097          	auipc	ra,0x0
    800064f0:	e18080e7          	jalr	-488(ra) # 80006304 <_ZN5mySem16checkWaitingListEv>
        if(!pointer) return -1;
    800064f4:	00005797          	auipc	a5,0x5
    800064f8:	18c78793          	addi	a5,a5,396 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    800064fc:	0287b783          	ld	a5,40(a5)
    80006500:	f8078ce3          	beqz	a5,80006498 <_ZN5mySem17checkAllTimedSemsEv+0x1c>
        pointer = pointer->next;
    80006504:	0087b783          	ld	a5,8(a5)
    80006508:	00005717          	auipc	a4,0x5
    8000650c:	1af73023          	sd	a5,416(a4) # 8000b6a8 <_ZN5mySem12allTimedSemsE+0x10>
        if(!pointer) return -1;
    80006510:	f80784e3          	beqz	a5,80006498 <_ZN5mySem17checkAllTimedSemsEv+0x1c>
        return pointer->data;
    80006514:	00005797          	auipc	a5,0x5
    80006518:	16c78793          	addi	a5,a5,364 # 8000b680 <_ZN5mySem13sleepingOnSemE>
    8000651c:	0287b783          	ld	a5,40(a5)
    80006520:	0007b503          	ld	a0,0(a5)
    80006524:	fc0514e3          	bnez	a0,800064ec <_ZN5mySem17checkAllTimedSemsEv+0x70>
    80006528:	fcdff06f          	j	800064f4 <_ZN5mySem17checkAllTimedSemsEv+0x78>
    8000652c:	00008067          	ret
    80006530:	00008067          	ret

0000000080006534 <_GLOBAL__sub_I__ZN5mySem13sleepingOnSemE>:
}
    80006534:	ff010113          	addi	sp,sp,-16
    80006538:	00113423          	sd	ra,8(sp)
    8000653c:	00813023          	sd	s0,0(sp)
    80006540:	01010413          	addi	s0,sp,16
    80006544:	000105b7          	lui	a1,0x10
    80006548:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    8000654c:	00100513          	li	a0,1
    80006550:	00000097          	auipc	ra,0x0
    80006554:	a38080e7          	jalr	-1480(ra) # 80005f88 <_Z41__static_initialization_and_destruction_0ii>
    80006558:	00813083          	ld	ra,8(sp)
    8000655c:	00013403          	ld	s0,0(sp)
    80006560:	01010113          	addi	sp,sp,16
    80006564:	00008067          	ret

0000000080006568 <start>:
    80006568:	ff010113          	addi	sp,sp,-16
    8000656c:	00813423          	sd	s0,8(sp)
    80006570:	01010413          	addi	s0,sp,16
    80006574:	300027f3          	csrr	a5,mstatus
    80006578:	ffffe737          	lui	a4,0xffffe
    8000657c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff1eef>
    80006580:	00e7f7b3          	and	a5,a5,a4
    80006584:	00001737          	lui	a4,0x1
    80006588:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    8000658c:	00e7e7b3          	or	a5,a5,a4
    80006590:	30079073          	csrw	mstatus,a5
    80006594:	00000797          	auipc	a5,0x0
    80006598:	16078793          	addi	a5,a5,352 # 800066f4 <system_main>
    8000659c:	34179073          	csrw	mepc,a5
    800065a0:	00000793          	li	a5,0
    800065a4:	18079073          	csrw	satp,a5
    800065a8:	000107b7          	lui	a5,0x10
    800065ac:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800065b0:	30279073          	csrw	medeleg,a5
    800065b4:	30379073          	csrw	mideleg,a5
    800065b8:	104027f3          	csrr	a5,sie
    800065bc:	2227e793          	ori	a5,a5,546
    800065c0:	10479073          	csrw	sie,a5
    800065c4:	fff00793          	li	a5,-1
    800065c8:	00a7d793          	srli	a5,a5,0xa
    800065cc:	3b079073          	csrw	pmpaddr0,a5
    800065d0:	00f00793          	li	a5,15
    800065d4:	3a079073          	csrw	pmpcfg0,a5
    800065d8:	f14027f3          	csrr	a5,mhartid
    800065dc:	0200c737          	lui	a4,0x200c
    800065e0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800065e4:	0007869b          	sext.w	a3,a5
    800065e8:	00269713          	slli	a4,a3,0x2
    800065ec:	000f4637          	lui	a2,0xf4
    800065f0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800065f4:	00d70733          	add	a4,a4,a3
    800065f8:	0037979b          	slliw	a5,a5,0x3
    800065fc:	020046b7          	lui	a3,0x2004
    80006600:	00d787b3          	add	a5,a5,a3
    80006604:	00c585b3          	add	a1,a1,a2
    80006608:	00371693          	slli	a3,a4,0x3
    8000660c:	00005717          	auipc	a4,0x5
    80006610:	0a470713          	addi	a4,a4,164 # 8000b6b0 <timer_scratch>
    80006614:	00b7b023          	sd	a1,0(a5)
    80006618:	00d70733          	add	a4,a4,a3
    8000661c:	00f73c23          	sd	a5,24(a4)
    80006620:	02c73023          	sd	a2,32(a4)
    80006624:	34071073          	csrw	mscratch,a4
    80006628:	00000797          	auipc	a5,0x0
    8000662c:	6e878793          	addi	a5,a5,1768 # 80006d10 <timervec>
    80006630:	30579073          	csrw	mtvec,a5
    80006634:	300027f3          	csrr	a5,mstatus
    80006638:	0087e793          	ori	a5,a5,8
    8000663c:	30079073          	csrw	mstatus,a5
    80006640:	304027f3          	csrr	a5,mie
    80006644:	0807e793          	ori	a5,a5,128
    80006648:	30479073          	csrw	mie,a5
    8000664c:	f14027f3          	csrr	a5,mhartid
    80006650:	0007879b          	sext.w	a5,a5
    80006654:	00078213          	mv	tp,a5
    80006658:	30200073          	mret
    8000665c:	00813403          	ld	s0,8(sp)
    80006660:	01010113          	addi	sp,sp,16
    80006664:	00008067          	ret

0000000080006668 <timerinit>:
    80006668:	ff010113          	addi	sp,sp,-16
    8000666c:	00813423          	sd	s0,8(sp)
    80006670:	01010413          	addi	s0,sp,16
    80006674:	f14027f3          	csrr	a5,mhartid
    80006678:	0200c737          	lui	a4,0x200c
    8000667c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006680:	0007869b          	sext.w	a3,a5
    80006684:	00269713          	slli	a4,a3,0x2
    80006688:	000f4637          	lui	a2,0xf4
    8000668c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006690:	00d70733          	add	a4,a4,a3
    80006694:	0037979b          	slliw	a5,a5,0x3
    80006698:	020046b7          	lui	a3,0x2004
    8000669c:	00d787b3          	add	a5,a5,a3
    800066a0:	00c585b3          	add	a1,a1,a2
    800066a4:	00371693          	slli	a3,a4,0x3
    800066a8:	00005717          	auipc	a4,0x5
    800066ac:	00870713          	addi	a4,a4,8 # 8000b6b0 <timer_scratch>
    800066b0:	00b7b023          	sd	a1,0(a5)
    800066b4:	00d70733          	add	a4,a4,a3
    800066b8:	00f73c23          	sd	a5,24(a4)
    800066bc:	02c73023          	sd	a2,32(a4)
    800066c0:	34071073          	csrw	mscratch,a4
    800066c4:	00000797          	auipc	a5,0x0
    800066c8:	64c78793          	addi	a5,a5,1612 # 80006d10 <timervec>
    800066cc:	30579073          	csrw	mtvec,a5
    800066d0:	300027f3          	csrr	a5,mstatus
    800066d4:	0087e793          	ori	a5,a5,8
    800066d8:	30079073          	csrw	mstatus,a5
    800066dc:	304027f3          	csrr	a5,mie
    800066e0:	0807e793          	ori	a5,a5,128
    800066e4:	30479073          	csrw	mie,a5
    800066e8:	00813403          	ld	s0,8(sp)
    800066ec:	01010113          	addi	sp,sp,16
    800066f0:	00008067          	ret

00000000800066f4 <system_main>:
    800066f4:	fe010113          	addi	sp,sp,-32
    800066f8:	00813823          	sd	s0,16(sp)
    800066fc:	00913423          	sd	s1,8(sp)
    80006700:	00113c23          	sd	ra,24(sp)
    80006704:	02010413          	addi	s0,sp,32
    80006708:	00000097          	auipc	ra,0x0
    8000670c:	0c4080e7          	jalr	196(ra) # 800067cc <cpuid>
    80006710:	00005497          	auipc	s1,0x5
    80006714:	f1848493          	addi	s1,s1,-232 # 8000b628 <started>
    80006718:	02050263          	beqz	a0,8000673c <system_main+0x48>
    8000671c:	0004a783          	lw	a5,0(s1)
    80006720:	0007879b          	sext.w	a5,a5
    80006724:	fe078ce3          	beqz	a5,8000671c <system_main+0x28>
    80006728:	0ff0000f          	fence
    8000672c:	00003517          	auipc	a0,0x3
    80006730:	fac50513          	addi	a0,a0,-84 # 800096d8 <_ZTV9Semaphore+0x50>
    80006734:	00001097          	auipc	ra,0x1
    80006738:	a78080e7          	jalr	-1416(ra) # 800071ac <panic>
    8000673c:	00001097          	auipc	ra,0x1
    80006740:	9cc080e7          	jalr	-1588(ra) # 80007108 <consoleinit>
    80006744:	00001097          	auipc	ra,0x1
    80006748:	158080e7          	jalr	344(ra) # 8000789c <printfinit>
    8000674c:	00003517          	auipc	a0,0x3
    80006750:	d2c50513          	addi	a0,a0,-724 # 80009478 <_ZTV8Consumer+0x1a0>
    80006754:	00001097          	auipc	ra,0x1
    80006758:	ab4080e7          	jalr	-1356(ra) # 80007208 <__printf>
    8000675c:	00003517          	auipc	a0,0x3
    80006760:	f4c50513          	addi	a0,a0,-180 # 800096a8 <_ZTV9Semaphore+0x20>
    80006764:	00001097          	auipc	ra,0x1
    80006768:	aa4080e7          	jalr	-1372(ra) # 80007208 <__printf>
    8000676c:	00003517          	auipc	a0,0x3
    80006770:	d0c50513          	addi	a0,a0,-756 # 80009478 <_ZTV8Consumer+0x1a0>
    80006774:	00001097          	auipc	ra,0x1
    80006778:	a94080e7          	jalr	-1388(ra) # 80007208 <__printf>
    8000677c:	00001097          	auipc	ra,0x1
    80006780:	4ac080e7          	jalr	1196(ra) # 80007c28 <kinit>
    80006784:	00000097          	auipc	ra,0x0
    80006788:	148080e7          	jalr	328(ra) # 800068cc <trapinit>
    8000678c:	00000097          	auipc	ra,0x0
    80006790:	16c080e7          	jalr	364(ra) # 800068f8 <trapinithart>
    80006794:	00000097          	auipc	ra,0x0
    80006798:	5bc080e7          	jalr	1468(ra) # 80006d50 <plicinit>
    8000679c:	00000097          	auipc	ra,0x0
    800067a0:	5dc080e7          	jalr	1500(ra) # 80006d78 <plicinithart>
    800067a4:	00000097          	auipc	ra,0x0
    800067a8:	078080e7          	jalr	120(ra) # 8000681c <userinit>
    800067ac:	0ff0000f          	fence
    800067b0:	00100793          	li	a5,1
    800067b4:	00003517          	auipc	a0,0x3
    800067b8:	f0c50513          	addi	a0,a0,-244 # 800096c0 <_ZTV9Semaphore+0x38>
    800067bc:	00f4a023          	sw	a5,0(s1)
    800067c0:	00001097          	auipc	ra,0x1
    800067c4:	a48080e7          	jalr	-1464(ra) # 80007208 <__printf>
    800067c8:	0000006f          	j	800067c8 <system_main+0xd4>

00000000800067cc <cpuid>:
    800067cc:	ff010113          	addi	sp,sp,-16
    800067d0:	00813423          	sd	s0,8(sp)
    800067d4:	01010413          	addi	s0,sp,16
    800067d8:	00020513          	mv	a0,tp
    800067dc:	00813403          	ld	s0,8(sp)
    800067e0:	0005051b          	sext.w	a0,a0
    800067e4:	01010113          	addi	sp,sp,16
    800067e8:	00008067          	ret

00000000800067ec <mycpu>:
    800067ec:	ff010113          	addi	sp,sp,-16
    800067f0:	00813423          	sd	s0,8(sp)
    800067f4:	01010413          	addi	s0,sp,16
    800067f8:	00020793          	mv	a5,tp
    800067fc:	00813403          	ld	s0,8(sp)
    80006800:	0007879b          	sext.w	a5,a5
    80006804:	00779793          	slli	a5,a5,0x7
    80006808:	00006517          	auipc	a0,0x6
    8000680c:	ed850513          	addi	a0,a0,-296 # 8000c6e0 <cpus>
    80006810:	00f50533          	add	a0,a0,a5
    80006814:	01010113          	addi	sp,sp,16
    80006818:	00008067          	ret

000000008000681c <userinit>:
    8000681c:	ff010113          	addi	sp,sp,-16
    80006820:	00813423          	sd	s0,8(sp)
    80006824:	01010413          	addi	s0,sp,16
    80006828:	00813403          	ld	s0,8(sp)
    8000682c:	01010113          	addi	sp,sp,16
    80006830:	ffffe317          	auipc	t1,0xffffe
    80006834:	6e430067          	jr	1764(t1) # 80004f14 <main>

0000000080006838 <either_copyout>:
    80006838:	ff010113          	addi	sp,sp,-16
    8000683c:	00813023          	sd	s0,0(sp)
    80006840:	00113423          	sd	ra,8(sp)
    80006844:	01010413          	addi	s0,sp,16
    80006848:	02051663          	bnez	a0,80006874 <either_copyout+0x3c>
    8000684c:	00058513          	mv	a0,a1
    80006850:	00060593          	mv	a1,a2
    80006854:	0006861b          	sext.w	a2,a3
    80006858:	00002097          	auipc	ra,0x2
    8000685c:	c5c080e7          	jalr	-932(ra) # 800084b4 <__memmove>
    80006860:	00813083          	ld	ra,8(sp)
    80006864:	00013403          	ld	s0,0(sp)
    80006868:	00000513          	li	a0,0
    8000686c:	01010113          	addi	sp,sp,16
    80006870:	00008067          	ret
    80006874:	00003517          	auipc	a0,0x3
    80006878:	e8c50513          	addi	a0,a0,-372 # 80009700 <_ZTV9Semaphore+0x78>
    8000687c:	00001097          	auipc	ra,0x1
    80006880:	930080e7          	jalr	-1744(ra) # 800071ac <panic>

0000000080006884 <either_copyin>:
    80006884:	ff010113          	addi	sp,sp,-16
    80006888:	00813023          	sd	s0,0(sp)
    8000688c:	00113423          	sd	ra,8(sp)
    80006890:	01010413          	addi	s0,sp,16
    80006894:	02059463          	bnez	a1,800068bc <either_copyin+0x38>
    80006898:	00060593          	mv	a1,a2
    8000689c:	0006861b          	sext.w	a2,a3
    800068a0:	00002097          	auipc	ra,0x2
    800068a4:	c14080e7          	jalr	-1004(ra) # 800084b4 <__memmove>
    800068a8:	00813083          	ld	ra,8(sp)
    800068ac:	00013403          	ld	s0,0(sp)
    800068b0:	00000513          	li	a0,0
    800068b4:	01010113          	addi	sp,sp,16
    800068b8:	00008067          	ret
    800068bc:	00003517          	auipc	a0,0x3
    800068c0:	e6c50513          	addi	a0,a0,-404 # 80009728 <_ZTV9Semaphore+0xa0>
    800068c4:	00001097          	auipc	ra,0x1
    800068c8:	8e8080e7          	jalr	-1816(ra) # 800071ac <panic>

00000000800068cc <trapinit>:
    800068cc:	ff010113          	addi	sp,sp,-16
    800068d0:	00813423          	sd	s0,8(sp)
    800068d4:	01010413          	addi	s0,sp,16
    800068d8:	00813403          	ld	s0,8(sp)
    800068dc:	00003597          	auipc	a1,0x3
    800068e0:	e7458593          	addi	a1,a1,-396 # 80009750 <_ZTV9Semaphore+0xc8>
    800068e4:	00006517          	auipc	a0,0x6
    800068e8:	e7c50513          	addi	a0,a0,-388 # 8000c760 <tickslock>
    800068ec:	01010113          	addi	sp,sp,16
    800068f0:	00001317          	auipc	t1,0x1
    800068f4:	5c830067          	jr	1480(t1) # 80007eb8 <initlock>

00000000800068f8 <trapinithart>:
    800068f8:	ff010113          	addi	sp,sp,-16
    800068fc:	00813423          	sd	s0,8(sp)
    80006900:	01010413          	addi	s0,sp,16
    80006904:	00000797          	auipc	a5,0x0
    80006908:	2fc78793          	addi	a5,a5,764 # 80006c00 <kernelvec>
    8000690c:	10579073          	csrw	stvec,a5
    80006910:	00813403          	ld	s0,8(sp)
    80006914:	01010113          	addi	sp,sp,16
    80006918:	00008067          	ret

000000008000691c <usertrap>:
    8000691c:	ff010113          	addi	sp,sp,-16
    80006920:	00813423          	sd	s0,8(sp)
    80006924:	01010413          	addi	s0,sp,16
    80006928:	00813403          	ld	s0,8(sp)
    8000692c:	01010113          	addi	sp,sp,16
    80006930:	00008067          	ret

0000000080006934 <usertrapret>:
    80006934:	ff010113          	addi	sp,sp,-16
    80006938:	00813423          	sd	s0,8(sp)
    8000693c:	01010413          	addi	s0,sp,16
    80006940:	00813403          	ld	s0,8(sp)
    80006944:	01010113          	addi	sp,sp,16
    80006948:	00008067          	ret

000000008000694c <kerneltrap>:
    8000694c:	fe010113          	addi	sp,sp,-32
    80006950:	00813823          	sd	s0,16(sp)
    80006954:	00113c23          	sd	ra,24(sp)
    80006958:	00913423          	sd	s1,8(sp)
    8000695c:	02010413          	addi	s0,sp,32
    80006960:	142025f3          	csrr	a1,scause
    80006964:	100027f3          	csrr	a5,sstatus
    80006968:	0027f793          	andi	a5,a5,2
    8000696c:	10079c63          	bnez	a5,80006a84 <kerneltrap+0x138>
    80006970:	142027f3          	csrr	a5,scause
    80006974:	0207ce63          	bltz	a5,800069b0 <kerneltrap+0x64>
    80006978:	00003517          	auipc	a0,0x3
    8000697c:	e2050513          	addi	a0,a0,-480 # 80009798 <_ZTV9Semaphore+0x110>
    80006980:	00001097          	auipc	ra,0x1
    80006984:	888080e7          	jalr	-1912(ra) # 80007208 <__printf>
    80006988:	141025f3          	csrr	a1,sepc
    8000698c:	14302673          	csrr	a2,stval
    80006990:	00003517          	auipc	a0,0x3
    80006994:	e1850513          	addi	a0,a0,-488 # 800097a8 <_ZTV9Semaphore+0x120>
    80006998:	00001097          	auipc	ra,0x1
    8000699c:	870080e7          	jalr	-1936(ra) # 80007208 <__printf>
    800069a0:	00003517          	auipc	a0,0x3
    800069a4:	e2050513          	addi	a0,a0,-480 # 800097c0 <_ZTV9Semaphore+0x138>
    800069a8:	00001097          	auipc	ra,0x1
    800069ac:	804080e7          	jalr	-2044(ra) # 800071ac <panic>
    800069b0:	0ff7f713          	andi	a4,a5,255
    800069b4:	00900693          	li	a3,9
    800069b8:	04d70063          	beq	a4,a3,800069f8 <kerneltrap+0xac>
    800069bc:	fff00713          	li	a4,-1
    800069c0:	03f71713          	slli	a4,a4,0x3f
    800069c4:	00170713          	addi	a4,a4,1
    800069c8:	fae798e3          	bne	a5,a4,80006978 <kerneltrap+0x2c>
    800069cc:	00000097          	auipc	ra,0x0
    800069d0:	e00080e7          	jalr	-512(ra) # 800067cc <cpuid>
    800069d4:	06050663          	beqz	a0,80006a40 <kerneltrap+0xf4>
    800069d8:	144027f3          	csrr	a5,sip
    800069dc:	ffd7f793          	andi	a5,a5,-3
    800069e0:	14479073          	csrw	sip,a5
    800069e4:	01813083          	ld	ra,24(sp)
    800069e8:	01013403          	ld	s0,16(sp)
    800069ec:	00813483          	ld	s1,8(sp)
    800069f0:	02010113          	addi	sp,sp,32
    800069f4:	00008067          	ret
    800069f8:	00000097          	auipc	ra,0x0
    800069fc:	3cc080e7          	jalr	972(ra) # 80006dc4 <plic_claim>
    80006a00:	00a00793          	li	a5,10
    80006a04:	00050493          	mv	s1,a0
    80006a08:	06f50863          	beq	a0,a5,80006a78 <kerneltrap+0x12c>
    80006a0c:	fc050ce3          	beqz	a0,800069e4 <kerneltrap+0x98>
    80006a10:	00050593          	mv	a1,a0
    80006a14:	00003517          	auipc	a0,0x3
    80006a18:	d6450513          	addi	a0,a0,-668 # 80009778 <_ZTV9Semaphore+0xf0>
    80006a1c:	00000097          	auipc	ra,0x0
    80006a20:	7ec080e7          	jalr	2028(ra) # 80007208 <__printf>
    80006a24:	01013403          	ld	s0,16(sp)
    80006a28:	01813083          	ld	ra,24(sp)
    80006a2c:	00048513          	mv	a0,s1
    80006a30:	00813483          	ld	s1,8(sp)
    80006a34:	02010113          	addi	sp,sp,32
    80006a38:	00000317          	auipc	t1,0x0
    80006a3c:	3c430067          	jr	964(t1) # 80006dfc <plic_complete>
    80006a40:	00006517          	auipc	a0,0x6
    80006a44:	d2050513          	addi	a0,a0,-736 # 8000c760 <tickslock>
    80006a48:	00001097          	auipc	ra,0x1
    80006a4c:	494080e7          	jalr	1172(ra) # 80007edc <acquire>
    80006a50:	00005717          	auipc	a4,0x5
    80006a54:	bdc70713          	addi	a4,a4,-1060 # 8000b62c <ticks>
    80006a58:	00072783          	lw	a5,0(a4)
    80006a5c:	00006517          	auipc	a0,0x6
    80006a60:	d0450513          	addi	a0,a0,-764 # 8000c760 <tickslock>
    80006a64:	0017879b          	addiw	a5,a5,1
    80006a68:	00f72023          	sw	a5,0(a4)
    80006a6c:	00001097          	auipc	ra,0x1
    80006a70:	53c080e7          	jalr	1340(ra) # 80007fa8 <release>
    80006a74:	f65ff06f          	j	800069d8 <kerneltrap+0x8c>
    80006a78:	00001097          	auipc	ra,0x1
    80006a7c:	098080e7          	jalr	152(ra) # 80007b10 <uartintr>
    80006a80:	fa5ff06f          	j	80006a24 <kerneltrap+0xd8>
    80006a84:	00003517          	auipc	a0,0x3
    80006a88:	cd450513          	addi	a0,a0,-812 # 80009758 <_ZTV9Semaphore+0xd0>
    80006a8c:	00000097          	auipc	ra,0x0
    80006a90:	720080e7          	jalr	1824(ra) # 800071ac <panic>

0000000080006a94 <clockintr>:
    80006a94:	fe010113          	addi	sp,sp,-32
    80006a98:	00813823          	sd	s0,16(sp)
    80006a9c:	00913423          	sd	s1,8(sp)
    80006aa0:	00113c23          	sd	ra,24(sp)
    80006aa4:	02010413          	addi	s0,sp,32
    80006aa8:	00006497          	auipc	s1,0x6
    80006aac:	cb848493          	addi	s1,s1,-840 # 8000c760 <tickslock>
    80006ab0:	00048513          	mv	a0,s1
    80006ab4:	00001097          	auipc	ra,0x1
    80006ab8:	428080e7          	jalr	1064(ra) # 80007edc <acquire>
    80006abc:	00005717          	auipc	a4,0x5
    80006ac0:	b7070713          	addi	a4,a4,-1168 # 8000b62c <ticks>
    80006ac4:	00072783          	lw	a5,0(a4)
    80006ac8:	01013403          	ld	s0,16(sp)
    80006acc:	01813083          	ld	ra,24(sp)
    80006ad0:	00048513          	mv	a0,s1
    80006ad4:	0017879b          	addiw	a5,a5,1
    80006ad8:	00813483          	ld	s1,8(sp)
    80006adc:	00f72023          	sw	a5,0(a4)
    80006ae0:	02010113          	addi	sp,sp,32
    80006ae4:	00001317          	auipc	t1,0x1
    80006ae8:	4c430067          	jr	1220(t1) # 80007fa8 <release>

0000000080006aec <devintr>:
    80006aec:	142027f3          	csrr	a5,scause
    80006af0:	00000513          	li	a0,0
    80006af4:	0007c463          	bltz	a5,80006afc <devintr+0x10>
    80006af8:	00008067          	ret
    80006afc:	fe010113          	addi	sp,sp,-32
    80006b00:	00813823          	sd	s0,16(sp)
    80006b04:	00113c23          	sd	ra,24(sp)
    80006b08:	00913423          	sd	s1,8(sp)
    80006b0c:	02010413          	addi	s0,sp,32
    80006b10:	0ff7f713          	andi	a4,a5,255
    80006b14:	00900693          	li	a3,9
    80006b18:	04d70c63          	beq	a4,a3,80006b70 <devintr+0x84>
    80006b1c:	fff00713          	li	a4,-1
    80006b20:	03f71713          	slli	a4,a4,0x3f
    80006b24:	00170713          	addi	a4,a4,1
    80006b28:	00e78c63          	beq	a5,a4,80006b40 <devintr+0x54>
    80006b2c:	01813083          	ld	ra,24(sp)
    80006b30:	01013403          	ld	s0,16(sp)
    80006b34:	00813483          	ld	s1,8(sp)
    80006b38:	02010113          	addi	sp,sp,32
    80006b3c:	00008067          	ret
    80006b40:	00000097          	auipc	ra,0x0
    80006b44:	c8c080e7          	jalr	-884(ra) # 800067cc <cpuid>
    80006b48:	06050663          	beqz	a0,80006bb4 <devintr+0xc8>
    80006b4c:	144027f3          	csrr	a5,sip
    80006b50:	ffd7f793          	andi	a5,a5,-3
    80006b54:	14479073          	csrw	sip,a5
    80006b58:	01813083          	ld	ra,24(sp)
    80006b5c:	01013403          	ld	s0,16(sp)
    80006b60:	00813483          	ld	s1,8(sp)
    80006b64:	00200513          	li	a0,2
    80006b68:	02010113          	addi	sp,sp,32
    80006b6c:	00008067          	ret
    80006b70:	00000097          	auipc	ra,0x0
    80006b74:	254080e7          	jalr	596(ra) # 80006dc4 <plic_claim>
    80006b78:	00a00793          	li	a5,10
    80006b7c:	00050493          	mv	s1,a0
    80006b80:	06f50663          	beq	a0,a5,80006bec <devintr+0x100>
    80006b84:	00100513          	li	a0,1
    80006b88:	fa0482e3          	beqz	s1,80006b2c <devintr+0x40>
    80006b8c:	00048593          	mv	a1,s1
    80006b90:	00003517          	auipc	a0,0x3
    80006b94:	be850513          	addi	a0,a0,-1048 # 80009778 <_ZTV9Semaphore+0xf0>
    80006b98:	00000097          	auipc	ra,0x0
    80006b9c:	670080e7          	jalr	1648(ra) # 80007208 <__printf>
    80006ba0:	00048513          	mv	a0,s1
    80006ba4:	00000097          	auipc	ra,0x0
    80006ba8:	258080e7          	jalr	600(ra) # 80006dfc <plic_complete>
    80006bac:	00100513          	li	a0,1
    80006bb0:	f7dff06f          	j	80006b2c <devintr+0x40>
    80006bb4:	00006517          	auipc	a0,0x6
    80006bb8:	bac50513          	addi	a0,a0,-1108 # 8000c760 <tickslock>
    80006bbc:	00001097          	auipc	ra,0x1
    80006bc0:	320080e7          	jalr	800(ra) # 80007edc <acquire>
    80006bc4:	00005717          	auipc	a4,0x5
    80006bc8:	a6870713          	addi	a4,a4,-1432 # 8000b62c <ticks>
    80006bcc:	00072783          	lw	a5,0(a4)
    80006bd0:	00006517          	auipc	a0,0x6
    80006bd4:	b9050513          	addi	a0,a0,-1136 # 8000c760 <tickslock>
    80006bd8:	0017879b          	addiw	a5,a5,1
    80006bdc:	00f72023          	sw	a5,0(a4)
    80006be0:	00001097          	auipc	ra,0x1
    80006be4:	3c8080e7          	jalr	968(ra) # 80007fa8 <release>
    80006be8:	f65ff06f          	j	80006b4c <devintr+0x60>
    80006bec:	00001097          	auipc	ra,0x1
    80006bf0:	f24080e7          	jalr	-220(ra) # 80007b10 <uartintr>
    80006bf4:	fadff06f          	j	80006ba0 <devintr+0xb4>
	...

0000000080006c00 <kernelvec>:
    80006c00:	f0010113          	addi	sp,sp,-256
    80006c04:	00113023          	sd	ra,0(sp)
    80006c08:	00213423          	sd	sp,8(sp)
    80006c0c:	00313823          	sd	gp,16(sp)
    80006c10:	00413c23          	sd	tp,24(sp)
    80006c14:	02513023          	sd	t0,32(sp)
    80006c18:	02613423          	sd	t1,40(sp)
    80006c1c:	02713823          	sd	t2,48(sp)
    80006c20:	02813c23          	sd	s0,56(sp)
    80006c24:	04913023          	sd	s1,64(sp)
    80006c28:	04a13423          	sd	a0,72(sp)
    80006c2c:	04b13823          	sd	a1,80(sp)
    80006c30:	04c13c23          	sd	a2,88(sp)
    80006c34:	06d13023          	sd	a3,96(sp)
    80006c38:	06e13423          	sd	a4,104(sp)
    80006c3c:	06f13823          	sd	a5,112(sp)
    80006c40:	07013c23          	sd	a6,120(sp)
    80006c44:	09113023          	sd	a7,128(sp)
    80006c48:	09213423          	sd	s2,136(sp)
    80006c4c:	09313823          	sd	s3,144(sp)
    80006c50:	09413c23          	sd	s4,152(sp)
    80006c54:	0b513023          	sd	s5,160(sp)
    80006c58:	0b613423          	sd	s6,168(sp)
    80006c5c:	0b713823          	sd	s7,176(sp)
    80006c60:	0b813c23          	sd	s8,184(sp)
    80006c64:	0d913023          	sd	s9,192(sp)
    80006c68:	0da13423          	sd	s10,200(sp)
    80006c6c:	0db13823          	sd	s11,208(sp)
    80006c70:	0dc13c23          	sd	t3,216(sp)
    80006c74:	0fd13023          	sd	t4,224(sp)
    80006c78:	0fe13423          	sd	t5,232(sp)
    80006c7c:	0ff13823          	sd	t6,240(sp)
    80006c80:	ccdff0ef          	jal	ra,8000694c <kerneltrap>
    80006c84:	00013083          	ld	ra,0(sp)
    80006c88:	00813103          	ld	sp,8(sp)
    80006c8c:	01013183          	ld	gp,16(sp)
    80006c90:	02013283          	ld	t0,32(sp)
    80006c94:	02813303          	ld	t1,40(sp)
    80006c98:	03013383          	ld	t2,48(sp)
    80006c9c:	03813403          	ld	s0,56(sp)
    80006ca0:	04013483          	ld	s1,64(sp)
    80006ca4:	04813503          	ld	a0,72(sp)
    80006ca8:	05013583          	ld	a1,80(sp)
    80006cac:	05813603          	ld	a2,88(sp)
    80006cb0:	06013683          	ld	a3,96(sp)
    80006cb4:	06813703          	ld	a4,104(sp)
    80006cb8:	07013783          	ld	a5,112(sp)
    80006cbc:	07813803          	ld	a6,120(sp)
    80006cc0:	08013883          	ld	a7,128(sp)
    80006cc4:	08813903          	ld	s2,136(sp)
    80006cc8:	09013983          	ld	s3,144(sp)
    80006ccc:	09813a03          	ld	s4,152(sp)
    80006cd0:	0a013a83          	ld	s5,160(sp)
    80006cd4:	0a813b03          	ld	s6,168(sp)
    80006cd8:	0b013b83          	ld	s7,176(sp)
    80006cdc:	0b813c03          	ld	s8,184(sp)
    80006ce0:	0c013c83          	ld	s9,192(sp)
    80006ce4:	0c813d03          	ld	s10,200(sp)
    80006ce8:	0d013d83          	ld	s11,208(sp)
    80006cec:	0d813e03          	ld	t3,216(sp)
    80006cf0:	0e013e83          	ld	t4,224(sp)
    80006cf4:	0e813f03          	ld	t5,232(sp)
    80006cf8:	0f013f83          	ld	t6,240(sp)
    80006cfc:	10010113          	addi	sp,sp,256
    80006d00:	10200073          	sret
    80006d04:	00000013          	nop
    80006d08:	00000013          	nop
    80006d0c:	00000013          	nop

0000000080006d10 <timervec>:
    80006d10:	34051573          	csrrw	a0,mscratch,a0
    80006d14:	00b53023          	sd	a1,0(a0)
    80006d18:	00c53423          	sd	a2,8(a0)
    80006d1c:	00d53823          	sd	a3,16(a0)
    80006d20:	01853583          	ld	a1,24(a0)
    80006d24:	02053603          	ld	a2,32(a0)
    80006d28:	0005b683          	ld	a3,0(a1)
    80006d2c:	00c686b3          	add	a3,a3,a2
    80006d30:	00d5b023          	sd	a3,0(a1)
    80006d34:	00200593          	li	a1,2
    80006d38:	14459073          	csrw	sip,a1
    80006d3c:	01053683          	ld	a3,16(a0)
    80006d40:	00853603          	ld	a2,8(a0)
    80006d44:	00053583          	ld	a1,0(a0)
    80006d48:	34051573          	csrrw	a0,mscratch,a0
    80006d4c:	30200073          	mret

0000000080006d50 <plicinit>:
    80006d50:	ff010113          	addi	sp,sp,-16
    80006d54:	00813423          	sd	s0,8(sp)
    80006d58:	01010413          	addi	s0,sp,16
    80006d5c:	00813403          	ld	s0,8(sp)
    80006d60:	0c0007b7          	lui	a5,0xc000
    80006d64:	00100713          	li	a4,1
    80006d68:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80006d6c:	00e7a223          	sw	a4,4(a5)
    80006d70:	01010113          	addi	sp,sp,16
    80006d74:	00008067          	ret

0000000080006d78 <plicinithart>:
    80006d78:	ff010113          	addi	sp,sp,-16
    80006d7c:	00813023          	sd	s0,0(sp)
    80006d80:	00113423          	sd	ra,8(sp)
    80006d84:	01010413          	addi	s0,sp,16
    80006d88:	00000097          	auipc	ra,0x0
    80006d8c:	a44080e7          	jalr	-1468(ra) # 800067cc <cpuid>
    80006d90:	0085171b          	slliw	a4,a0,0x8
    80006d94:	0c0027b7          	lui	a5,0xc002
    80006d98:	00e787b3          	add	a5,a5,a4
    80006d9c:	40200713          	li	a4,1026
    80006da0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006da4:	00813083          	ld	ra,8(sp)
    80006da8:	00013403          	ld	s0,0(sp)
    80006dac:	00d5151b          	slliw	a0,a0,0xd
    80006db0:	0c2017b7          	lui	a5,0xc201
    80006db4:	00a78533          	add	a0,a5,a0
    80006db8:	00052023          	sw	zero,0(a0)
    80006dbc:	01010113          	addi	sp,sp,16
    80006dc0:	00008067          	ret

0000000080006dc4 <plic_claim>:
    80006dc4:	ff010113          	addi	sp,sp,-16
    80006dc8:	00813023          	sd	s0,0(sp)
    80006dcc:	00113423          	sd	ra,8(sp)
    80006dd0:	01010413          	addi	s0,sp,16
    80006dd4:	00000097          	auipc	ra,0x0
    80006dd8:	9f8080e7          	jalr	-1544(ra) # 800067cc <cpuid>
    80006ddc:	00813083          	ld	ra,8(sp)
    80006de0:	00013403          	ld	s0,0(sp)
    80006de4:	00d5151b          	slliw	a0,a0,0xd
    80006de8:	0c2017b7          	lui	a5,0xc201
    80006dec:	00a78533          	add	a0,a5,a0
    80006df0:	00452503          	lw	a0,4(a0)
    80006df4:	01010113          	addi	sp,sp,16
    80006df8:	00008067          	ret

0000000080006dfc <plic_complete>:
    80006dfc:	fe010113          	addi	sp,sp,-32
    80006e00:	00813823          	sd	s0,16(sp)
    80006e04:	00913423          	sd	s1,8(sp)
    80006e08:	00113c23          	sd	ra,24(sp)
    80006e0c:	02010413          	addi	s0,sp,32
    80006e10:	00050493          	mv	s1,a0
    80006e14:	00000097          	auipc	ra,0x0
    80006e18:	9b8080e7          	jalr	-1608(ra) # 800067cc <cpuid>
    80006e1c:	01813083          	ld	ra,24(sp)
    80006e20:	01013403          	ld	s0,16(sp)
    80006e24:	00d5179b          	slliw	a5,a0,0xd
    80006e28:	0c201737          	lui	a4,0xc201
    80006e2c:	00f707b3          	add	a5,a4,a5
    80006e30:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80006e34:	00813483          	ld	s1,8(sp)
    80006e38:	02010113          	addi	sp,sp,32
    80006e3c:	00008067          	ret

0000000080006e40 <consolewrite>:
    80006e40:	fb010113          	addi	sp,sp,-80
    80006e44:	04813023          	sd	s0,64(sp)
    80006e48:	04113423          	sd	ra,72(sp)
    80006e4c:	02913c23          	sd	s1,56(sp)
    80006e50:	03213823          	sd	s2,48(sp)
    80006e54:	03313423          	sd	s3,40(sp)
    80006e58:	03413023          	sd	s4,32(sp)
    80006e5c:	01513c23          	sd	s5,24(sp)
    80006e60:	05010413          	addi	s0,sp,80
    80006e64:	06c05c63          	blez	a2,80006edc <consolewrite+0x9c>
    80006e68:	00060993          	mv	s3,a2
    80006e6c:	00050a13          	mv	s4,a0
    80006e70:	00058493          	mv	s1,a1
    80006e74:	00000913          	li	s2,0
    80006e78:	fff00a93          	li	s5,-1
    80006e7c:	01c0006f          	j	80006e98 <consolewrite+0x58>
    80006e80:	fbf44503          	lbu	a0,-65(s0)
    80006e84:	0019091b          	addiw	s2,s2,1
    80006e88:	00148493          	addi	s1,s1,1
    80006e8c:	00001097          	auipc	ra,0x1
    80006e90:	a9c080e7          	jalr	-1380(ra) # 80007928 <uartputc>
    80006e94:	03298063          	beq	s3,s2,80006eb4 <consolewrite+0x74>
    80006e98:	00048613          	mv	a2,s1
    80006e9c:	00100693          	li	a3,1
    80006ea0:	000a0593          	mv	a1,s4
    80006ea4:	fbf40513          	addi	a0,s0,-65
    80006ea8:	00000097          	auipc	ra,0x0
    80006eac:	9dc080e7          	jalr	-1572(ra) # 80006884 <either_copyin>
    80006eb0:	fd5518e3          	bne	a0,s5,80006e80 <consolewrite+0x40>
    80006eb4:	04813083          	ld	ra,72(sp)
    80006eb8:	04013403          	ld	s0,64(sp)
    80006ebc:	03813483          	ld	s1,56(sp)
    80006ec0:	02813983          	ld	s3,40(sp)
    80006ec4:	02013a03          	ld	s4,32(sp)
    80006ec8:	01813a83          	ld	s5,24(sp)
    80006ecc:	00090513          	mv	a0,s2
    80006ed0:	03013903          	ld	s2,48(sp)
    80006ed4:	05010113          	addi	sp,sp,80
    80006ed8:	00008067          	ret
    80006edc:	00000913          	li	s2,0
    80006ee0:	fd5ff06f          	j	80006eb4 <consolewrite+0x74>

0000000080006ee4 <consoleread>:
    80006ee4:	f9010113          	addi	sp,sp,-112
    80006ee8:	06813023          	sd	s0,96(sp)
    80006eec:	04913c23          	sd	s1,88(sp)
    80006ef0:	05213823          	sd	s2,80(sp)
    80006ef4:	05313423          	sd	s3,72(sp)
    80006ef8:	05413023          	sd	s4,64(sp)
    80006efc:	03513c23          	sd	s5,56(sp)
    80006f00:	03613823          	sd	s6,48(sp)
    80006f04:	03713423          	sd	s7,40(sp)
    80006f08:	03813023          	sd	s8,32(sp)
    80006f0c:	06113423          	sd	ra,104(sp)
    80006f10:	01913c23          	sd	s9,24(sp)
    80006f14:	07010413          	addi	s0,sp,112
    80006f18:	00060b93          	mv	s7,a2
    80006f1c:	00050913          	mv	s2,a0
    80006f20:	00058c13          	mv	s8,a1
    80006f24:	00060b1b          	sext.w	s6,a2
    80006f28:	00006497          	auipc	s1,0x6
    80006f2c:	86048493          	addi	s1,s1,-1952 # 8000c788 <cons>
    80006f30:	00400993          	li	s3,4
    80006f34:	fff00a13          	li	s4,-1
    80006f38:	00a00a93          	li	s5,10
    80006f3c:	05705e63          	blez	s7,80006f98 <consoleread+0xb4>
    80006f40:	09c4a703          	lw	a4,156(s1)
    80006f44:	0984a783          	lw	a5,152(s1)
    80006f48:	0007071b          	sext.w	a4,a4
    80006f4c:	08e78463          	beq	a5,a4,80006fd4 <consoleread+0xf0>
    80006f50:	07f7f713          	andi	a4,a5,127
    80006f54:	00e48733          	add	a4,s1,a4
    80006f58:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80006f5c:	0017869b          	addiw	a3,a5,1
    80006f60:	08d4ac23          	sw	a3,152(s1)
    80006f64:	00070c9b          	sext.w	s9,a4
    80006f68:	0b370663          	beq	a4,s3,80007014 <consoleread+0x130>
    80006f6c:	00100693          	li	a3,1
    80006f70:	f9f40613          	addi	a2,s0,-97
    80006f74:	000c0593          	mv	a1,s8
    80006f78:	00090513          	mv	a0,s2
    80006f7c:	f8e40fa3          	sb	a4,-97(s0)
    80006f80:	00000097          	auipc	ra,0x0
    80006f84:	8b8080e7          	jalr	-1864(ra) # 80006838 <either_copyout>
    80006f88:	01450863          	beq	a0,s4,80006f98 <consoleread+0xb4>
    80006f8c:	001c0c13          	addi	s8,s8,1
    80006f90:	fffb8b9b          	addiw	s7,s7,-1
    80006f94:	fb5c94e3          	bne	s9,s5,80006f3c <consoleread+0x58>
    80006f98:	000b851b          	sext.w	a0,s7
    80006f9c:	06813083          	ld	ra,104(sp)
    80006fa0:	06013403          	ld	s0,96(sp)
    80006fa4:	05813483          	ld	s1,88(sp)
    80006fa8:	05013903          	ld	s2,80(sp)
    80006fac:	04813983          	ld	s3,72(sp)
    80006fb0:	04013a03          	ld	s4,64(sp)
    80006fb4:	03813a83          	ld	s5,56(sp)
    80006fb8:	02813b83          	ld	s7,40(sp)
    80006fbc:	02013c03          	ld	s8,32(sp)
    80006fc0:	01813c83          	ld	s9,24(sp)
    80006fc4:	40ab053b          	subw	a0,s6,a0
    80006fc8:	03013b03          	ld	s6,48(sp)
    80006fcc:	07010113          	addi	sp,sp,112
    80006fd0:	00008067          	ret
    80006fd4:	00001097          	auipc	ra,0x1
    80006fd8:	1d8080e7          	jalr	472(ra) # 800081ac <push_on>
    80006fdc:	0984a703          	lw	a4,152(s1)
    80006fe0:	09c4a783          	lw	a5,156(s1)
    80006fe4:	0007879b          	sext.w	a5,a5
    80006fe8:	fef70ce3          	beq	a4,a5,80006fe0 <consoleread+0xfc>
    80006fec:	00001097          	auipc	ra,0x1
    80006ff0:	234080e7          	jalr	564(ra) # 80008220 <pop_on>
    80006ff4:	0984a783          	lw	a5,152(s1)
    80006ff8:	07f7f713          	andi	a4,a5,127
    80006ffc:	00e48733          	add	a4,s1,a4
    80007000:	01874703          	lbu	a4,24(a4)
    80007004:	0017869b          	addiw	a3,a5,1
    80007008:	08d4ac23          	sw	a3,152(s1)
    8000700c:	00070c9b          	sext.w	s9,a4
    80007010:	f5371ee3          	bne	a4,s3,80006f6c <consoleread+0x88>
    80007014:	000b851b          	sext.w	a0,s7
    80007018:	f96bf2e3          	bgeu	s7,s6,80006f9c <consoleread+0xb8>
    8000701c:	08f4ac23          	sw	a5,152(s1)
    80007020:	f7dff06f          	j	80006f9c <consoleread+0xb8>

0000000080007024 <consputc>:
    80007024:	10000793          	li	a5,256
    80007028:	00f50663          	beq	a0,a5,80007034 <consputc+0x10>
    8000702c:	00001317          	auipc	t1,0x1
    80007030:	9f430067          	jr	-1548(t1) # 80007a20 <uartputc_sync>
    80007034:	ff010113          	addi	sp,sp,-16
    80007038:	00113423          	sd	ra,8(sp)
    8000703c:	00813023          	sd	s0,0(sp)
    80007040:	01010413          	addi	s0,sp,16
    80007044:	00800513          	li	a0,8
    80007048:	00001097          	auipc	ra,0x1
    8000704c:	9d8080e7          	jalr	-1576(ra) # 80007a20 <uartputc_sync>
    80007050:	02000513          	li	a0,32
    80007054:	00001097          	auipc	ra,0x1
    80007058:	9cc080e7          	jalr	-1588(ra) # 80007a20 <uartputc_sync>
    8000705c:	00013403          	ld	s0,0(sp)
    80007060:	00813083          	ld	ra,8(sp)
    80007064:	00800513          	li	a0,8
    80007068:	01010113          	addi	sp,sp,16
    8000706c:	00001317          	auipc	t1,0x1
    80007070:	9b430067          	jr	-1612(t1) # 80007a20 <uartputc_sync>

0000000080007074 <consoleintr>:
    80007074:	fe010113          	addi	sp,sp,-32
    80007078:	00813823          	sd	s0,16(sp)
    8000707c:	00913423          	sd	s1,8(sp)
    80007080:	01213023          	sd	s2,0(sp)
    80007084:	00113c23          	sd	ra,24(sp)
    80007088:	02010413          	addi	s0,sp,32
    8000708c:	00005917          	auipc	s2,0x5
    80007090:	6fc90913          	addi	s2,s2,1788 # 8000c788 <cons>
    80007094:	00050493          	mv	s1,a0
    80007098:	00090513          	mv	a0,s2
    8000709c:	00001097          	auipc	ra,0x1
    800070a0:	e40080e7          	jalr	-448(ra) # 80007edc <acquire>
    800070a4:	02048c63          	beqz	s1,800070dc <consoleintr+0x68>
    800070a8:	0a092783          	lw	a5,160(s2)
    800070ac:	09892703          	lw	a4,152(s2)
    800070b0:	07f00693          	li	a3,127
    800070b4:	40e7873b          	subw	a4,a5,a4
    800070b8:	02e6e263          	bltu	a3,a4,800070dc <consoleintr+0x68>
    800070bc:	00d00713          	li	a4,13
    800070c0:	04e48063          	beq	s1,a4,80007100 <consoleintr+0x8c>
    800070c4:	07f7f713          	andi	a4,a5,127
    800070c8:	00e90733          	add	a4,s2,a4
    800070cc:	0017879b          	addiw	a5,a5,1
    800070d0:	0af92023          	sw	a5,160(s2)
    800070d4:	00970c23          	sb	s1,24(a4)
    800070d8:	08f92e23          	sw	a5,156(s2)
    800070dc:	01013403          	ld	s0,16(sp)
    800070e0:	01813083          	ld	ra,24(sp)
    800070e4:	00813483          	ld	s1,8(sp)
    800070e8:	00013903          	ld	s2,0(sp)
    800070ec:	00005517          	auipc	a0,0x5
    800070f0:	69c50513          	addi	a0,a0,1692 # 8000c788 <cons>
    800070f4:	02010113          	addi	sp,sp,32
    800070f8:	00001317          	auipc	t1,0x1
    800070fc:	eb030067          	jr	-336(t1) # 80007fa8 <release>
    80007100:	00a00493          	li	s1,10
    80007104:	fc1ff06f          	j	800070c4 <consoleintr+0x50>

0000000080007108 <consoleinit>:
    80007108:	fe010113          	addi	sp,sp,-32
    8000710c:	00113c23          	sd	ra,24(sp)
    80007110:	00813823          	sd	s0,16(sp)
    80007114:	00913423          	sd	s1,8(sp)
    80007118:	02010413          	addi	s0,sp,32
    8000711c:	00005497          	auipc	s1,0x5
    80007120:	66c48493          	addi	s1,s1,1644 # 8000c788 <cons>
    80007124:	00048513          	mv	a0,s1
    80007128:	00002597          	auipc	a1,0x2
    8000712c:	6a858593          	addi	a1,a1,1704 # 800097d0 <_ZTV9Semaphore+0x148>
    80007130:	00001097          	auipc	ra,0x1
    80007134:	d88080e7          	jalr	-632(ra) # 80007eb8 <initlock>
    80007138:	00000097          	auipc	ra,0x0
    8000713c:	7ac080e7          	jalr	1964(ra) # 800078e4 <uartinit>
    80007140:	01813083          	ld	ra,24(sp)
    80007144:	01013403          	ld	s0,16(sp)
    80007148:	00000797          	auipc	a5,0x0
    8000714c:	d9c78793          	addi	a5,a5,-612 # 80006ee4 <consoleread>
    80007150:	0af4bc23          	sd	a5,184(s1)
    80007154:	00000797          	auipc	a5,0x0
    80007158:	cec78793          	addi	a5,a5,-788 # 80006e40 <consolewrite>
    8000715c:	0cf4b023          	sd	a5,192(s1)
    80007160:	00813483          	ld	s1,8(sp)
    80007164:	02010113          	addi	sp,sp,32
    80007168:	00008067          	ret

000000008000716c <console_read>:
    8000716c:	ff010113          	addi	sp,sp,-16
    80007170:	00813423          	sd	s0,8(sp)
    80007174:	01010413          	addi	s0,sp,16
    80007178:	00813403          	ld	s0,8(sp)
    8000717c:	00005317          	auipc	t1,0x5
    80007180:	6c433303          	ld	t1,1732(t1) # 8000c840 <devsw+0x10>
    80007184:	01010113          	addi	sp,sp,16
    80007188:	00030067          	jr	t1

000000008000718c <console_write>:
    8000718c:	ff010113          	addi	sp,sp,-16
    80007190:	00813423          	sd	s0,8(sp)
    80007194:	01010413          	addi	s0,sp,16
    80007198:	00813403          	ld	s0,8(sp)
    8000719c:	00005317          	auipc	t1,0x5
    800071a0:	6ac33303          	ld	t1,1708(t1) # 8000c848 <devsw+0x18>
    800071a4:	01010113          	addi	sp,sp,16
    800071a8:	00030067          	jr	t1

00000000800071ac <panic>:
    800071ac:	fe010113          	addi	sp,sp,-32
    800071b0:	00113c23          	sd	ra,24(sp)
    800071b4:	00813823          	sd	s0,16(sp)
    800071b8:	00913423          	sd	s1,8(sp)
    800071bc:	02010413          	addi	s0,sp,32
    800071c0:	00050493          	mv	s1,a0
    800071c4:	00002517          	auipc	a0,0x2
    800071c8:	61450513          	addi	a0,a0,1556 # 800097d8 <_ZTV9Semaphore+0x150>
    800071cc:	00005797          	auipc	a5,0x5
    800071d0:	7007ae23          	sw	zero,1820(a5) # 8000c8e8 <pr+0x18>
    800071d4:	00000097          	auipc	ra,0x0
    800071d8:	034080e7          	jalr	52(ra) # 80007208 <__printf>
    800071dc:	00048513          	mv	a0,s1
    800071e0:	00000097          	auipc	ra,0x0
    800071e4:	028080e7          	jalr	40(ra) # 80007208 <__printf>
    800071e8:	00002517          	auipc	a0,0x2
    800071ec:	29050513          	addi	a0,a0,656 # 80009478 <_ZTV8Consumer+0x1a0>
    800071f0:	00000097          	auipc	ra,0x0
    800071f4:	018080e7          	jalr	24(ra) # 80007208 <__printf>
    800071f8:	00100793          	li	a5,1
    800071fc:	00004717          	auipc	a4,0x4
    80007200:	42f72a23          	sw	a5,1076(a4) # 8000b630 <panicked>
    80007204:	0000006f          	j	80007204 <panic+0x58>

0000000080007208 <__printf>:
    80007208:	f3010113          	addi	sp,sp,-208
    8000720c:	08813023          	sd	s0,128(sp)
    80007210:	07313423          	sd	s3,104(sp)
    80007214:	09010413          	addi	s0,sp,144
    80007218:	05813023          	sd	s8,64(sp)
    8000721c:	08113423          	sd	ra,136(sp)
    80007220:	06913c23          	sd	s1,120(sp)
    80007224:	07213823          	sd	s2,112(sp)
    80007228:	07413023          	sd	s4,96(sp)
    8000722c:	05513c23          	sd	s5,88(sp)
    80007230:	05613823          	sd	s6,80(sp)
    80007234:	05713423          	sd	s7,72(sp)
    80007238:	03913c23          	sd	s9,56(sp)
    8000723c:	03a13823          	sd	s10,48(sp)
    80007240:	03b13423          	sd	s11,40(sp)
    80007244:	00005317          	auipc	t1,0x5
    80007248:	68c30313          	addi	t1,t1,1676 # 8000c8d0 <pr>
    8000724c:	01832c03          	lw	s8,24(t1)
    80007250:	00b43423          	sd	a1,8(s0)
    80007254:	00c43823          	sd	a2,16(s0)
    80007258:	00d43c23          	sd	a3,24(s0)
    8000725c:	02e43023          	sd	a4,32(s0)
    80007260:	02f43423          	sd	a5,40(s0)
    80007264:	03043823          	sd	a6,48(s0)
    80007268:	03143c23          	sd	a7,56(s0)
    8000726c:	00050993          	mv	s3,a0
    80007270:	4a0c1663          	bnez	s8,8000771c <__printf+0x514>
    80007274:	60098c63          	beqz	s3,8000788c <__printf+0x684>
    80007278:	0009c503          	lbu	a0,0(s3)
    8000727c:	00840793          	addi	a5,s0,8
    80007280:	f6f43c23          	sd	a5,-136(s0)
    80007284:	00000493          	li	s1,0
    80007288:	22050063          	beqz	a0,800074a8 <__printf+0x2a0>
    8000728c:	00002a37          	lui	s4,0x2
    80007290:	00018ab7          	lui	s5,0x18
    80007294:	000f4b37          	lui	s6,0xf4
    80007298:	00989bb7          	lui	s7,0x989
    8000729c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800072a0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800072a4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800072a8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800072ac:	00148c9b          	addiw	s9,s1,1
    800072b0:	02500793          	li	a5,37
    800072b4:	01998933          	add	s2,s3,s9
    800072b8:	38f51263          	bne	a0,a5,8000763c <__printf+0x434>
    800072bc:	00094783          	lbu	a5,0(s2)
    800072c0:	00078c9b          	sext.w	s9,a5
    800072c4:	1e078263          	beqz	a5,800074a8 <__printf+0x2a0>
    800072c8:	0024849b          	addiw	s1,s1,2
    800072cc:	07000713          	li	a4,112
    800072d0:	00998933          	add	s2,s3,s1
    800072d4:	38e78a63          	beq	a5,a4,80007668 <__printf+0x460>
    800072d8:	20f76863          	bltu	a4,a5,800074e8 <__printf+0x2e0>
    800072dc:	42a78863          	beq	a5,a0,8000770c <__printf+0x504>
    800072e0:	06400713          	li	a4,100
    800072e4:	40e79663          	bne	a5,a4,800076f0 <__printf+0x4e8>
    800072e8:	f7843783          	ld	a5,-136(s0)
    800072ec:	0007a603          	lw	a2,0(a5)
    800072f0:	00878793          	addi	a5,a5,8
    800072f4:	f6f43c23          	sd	a5,-136(s0)
    800072f8:	42064a63          	bltz	a2,8000772c <__printf+0x524>
    800072fc:	00a00713          	li	a4,10
    80007300:	02e677bb          	remuw	a5,a2,a4
    80007304:	00002d97          	auipc	s11,0x2
    80007308:	4fcd8d93          	addi	s11,s11,1276 # 80009800 <digits>
    8000730c:	00900593          	li	a1,9
    80007310:	0006051b          	sext.w	a0,a2
    80007314:	00000c93          	li	s9,0
    80007318:	02079793          	slli	a5,a5,0x20
    8000731c:	0207d793          	srli	a5,a5,0x20
    80007320:	00fd87b3          	add	a5,s11,a5
    80007324:	0007c783          	lbu	a5,0(a5)
    80007328:	02e656bb          	divuw	a3,a2,a4
    8000732c:	f8f40023          	sb	a5,-128(s0)
    80007330:	14c5d863          	bge	a1,a2,80007480 <__printf+0x278>
    80007334:	06300593          	li	a1,99
    80007338:	00100c93          	li	s9,1
    8000733c:	02e6f7bb          	remuw	a5,a3,a4
    80007340:	02079793          	slli	a5,a5,0x20
    80007344:	0207d793          	srli	a5,a5,0x20
    80007348:	00fd87b3          	add	a5,s11,a5
    8000734c:	0007c783          	lbu	a5,0(a5)
    80007350:	02e6d73b          	divuw	a4,a3,a4
    80007354:	f8f400a3          	sb	a5,-127(s0)
    80007358:	12a5f463          	bgeu	a1,a0,80007480 <__printf+0x278>
    8000735c:	00a00693          	li	a3,10
    80007360:	00900593          	li	a1,9
    80007364:	02d777bb          	remuw	a5,a4,a3
    80007368:	02079793          	slli	a5,a5,0x20
    8000736c:	0207d793          	srli	a5,a5,0x20
    80007370:	00fd87b3          	add	a5,s11,a5
    80007374:	0007c503          	lbu	a0,0(a5)
    80007378:	02d757bb          	divuw	a5,a4,a3
    8000737c:	f8a40123          	sb	a0,-126(s0)
    80007380:	48e5f263          	bgeu	a1,a4,80007804 <__printf+0x5fc>
    80007384:	06300513          	li	a0,99
    80007388:	02d7f5bb          	remuw	a1,a5,a3
    8000738c:	02059593          	slli	a1,a1,0x20
    80007390:	0205d593          	srli	a1,a1,0x20
    80007394:	00bd85b3          	add	a1,s11,a1
    80007398:	0005c583          	lbu	a1,0(a1)
    8000739c:	02d7d7bb          	divuw	a5,a5,a3
    800073a0:	f8b401a3          	sb	a1,-125(s0)
    800073a4:	48e57263          	bgeu	a0,a4,80007828 <__printf+0x620>
    800073a8:	3e700513          	li	a0,999
    800073ac:	02d7f5bb          	remuw	a1,a5,a3
    800073b0:	02059593          	slli	a1,a1,0x20
    800073b4:	0205d593          	srli	a1,a1,0x20
    800073b8:	00bd85b3          	add	a1,s11,a1
    800073bc:	0005c583          	lbu	a1,0(a1)
    800073c0:	02d7d7bb          	divuw	a5,a5,a3
    800073c4:	f8b40223          	sb	a1,-124(s0)
    800073c8:	46e57663          	bgeu	a0,a4,80007834 <__printf+0x62c>
    800073cc:	02d7f5bb          	remuw	a1,a5,a3
    800073d0:	02059593          	slli	a1,a1,0x20
    800073d4:	0205d593          	srli	a1,a1,0x20
    800073d8:	00bd85b3          	add	a1,s11,a1
    800073dc:	0005c583          	lbu	a1,0(a1)
    800073e0:	02d7d7bb          	divuw	a5,a5,a3
    800073e4:	f8b402a3          	sb	a1,-123(s0)
    800073e8:	46ea7863          	bgeu	s4,a4,80007858 <__printf+0x650>
    800073ec:	02d7f5bb          	remuw	a1,a5,a3
    800073f0:	02059593          	slli	a1,a1,0x20
    800073f4:	0205d593          	srli	a1,a1,0x20
    800073f8:	00bd85b3          	add	a1,s11,a1
    800073fc:	0005c583          	lbu	a1,0(a1)
    80007400:	02d7d7bb          	divuw	a5,a5,a3
    80007404:	f8b40323          	sb	a1,-122(s0)
    80007408:	3eeaf863          	bgeu	s5,a4,800077f8 <__printf+0x5f0>
    8000740c:	02d7f5bb          	remuw	a1,a5,a3
    80007410:	02059593          	slli	a1,a1,0x20
    80007414:	0205d593          	srli	a1,a1,0x20
    80007418:	00bd85b3          	add	a1,s11,a1
    8000741c:	0005c583          	lbu	a1,0(a1)
    80007420:	02d7d7bb          	divuw	a5,a5,a3
    80007424:	f8b403a3          	sb	a1,-121(s0)
    80007428:	42eb7e63          	bgeu	s6,a4,80007864 <__printf+0x65c>
    8000742c:	02d7f5bb          	remuw	a1,a5,a3
    80007430:	02059593          	slli	a1,a1,0x20
    80007434:	0205d593          	srli	a1,a1,0x20
    80007438:	00bd85b3          	add	a1,s11,a1
    8000743c:	0005c583          	lbu	a1,0(a1)
    80007440:	02d7d7bb          	divuw	a5,a5,a3
    80007444:	f8b40423          	sb	a1,-120(s0)
    80007448:	42ebfc63          	bgeu	s7,a4,80007880 <__printf+0x678>
    8000744c:	02079793          	slli	a5,a5,0x20
    80007450:	0207d793          	srli	a5,a5,0x20
    80007454:	00fd8db3          	add	s11,s11,a5
    80007458:	000dc703          	lbu	a4,0(s11)
    8000745c:	00a00793          	li	a5,10
    80007460:	00900c93          	li	s9,9
    80007464:	f8e404a3          	sb	a4,-119(s0)
    80007468:	00065c63          	bgez	a2,80007480 <__printf+0x278>
    8000746c:	f9040713          	addi	a4,s0,-112
    80007470:	00f70733          	add	a4,a4,a5
    80007474:	02d00693          	li	a3,45
    80007478:	fed70823          	sb	a3,-16(a4)
    8000747c:	00078c93          	mv	s9,a5
    80007480:	f8040793          	addi	a5,s0,-128
    80007484:	01978cb3          	add	s9,a5,s9
    80007488:	f7f40d13          	addi	s10,s0,-129
    8000748c:	000cc503          	lbu	a0,0(s9)
    80007490:	fffc8c93          	addi	s9,s9,-1
    80007494:	00000097          	auipc	ra,0x0
    80007498:	b90080e7          	jalr	-1136(ra) # 80007024 <consputc>
    8000749c:	ffac98e3          	bne	s9,s10,8000748c <__printf+0x284>
    800074a0:	00094503          	lbu	a0,0(s2)
    800074a4:	e00514e3          	bnez	a0,800072ac <__printf+0xa4>
    800074a8:	1a0c1663          	bnez	s8,80007654 <__printf+0x44c>
    800074ac:	08813083          	ld	ra,136(sp)
    800074b0:	08013403          	ld	s0,128(sp)
    800074b4:	07813483          	ld	s1,120(sp)
    800074b8:	07013903          	ld	s2,112(sp)
    800074bc:	06813983          	ld	s3,104(sp)
    800074c0:	06013a03          	ld	s4,96(sp)
    800074c4:	05813a83          	ld	s5,88(sp)
    800074c8:	05013b03          	ld	s6,80(sp)
    800074cc:	04813b83          	ld	s7,72(sp)
    800074d0:	04013c03          	ld	s8,64(sp)
    800074d4:	03813c83          	ld	s9,56(sp)
    800074d8:	03013d03          	ld	s10,48(sp)
    800074dc:	02813d83          	ld	s11,40(sp)
    800074e0:	0d010113          	addi	sp,sp,208
    800074e4:	00008067          	ret
    800074e8:	07300713          	li	a4,115
    800074ec:	1ce78a63          	beq	a5,a4,800076c0 <__printf+0x4b8>
    800074f0:	07800713          	li	a4,120
    800074f4:	1ee79e63          	bne	a5,a4,800076f0 <__printf+0x4e8>
    800074f8:	f7843783          	ld	a5,-136(s0)
    800074fc:	0007a703          	lw	a4,0(a5)
    80007500:	00878793          	addi	a5,a5,8
    80007504:	f6f43c23          	sd	a5,-136(s0)
    80007508:	28074263          	bltz	a4,8000778c <__printf+0x584>
    8000750c:	00002d97          	auipc	s11,0x2
    80007510:	2f4d8d93          	addi	s11,s11,756 # 80009800 <digits>
    80007514:	00f77793          	andi	a5,a4,15
    80007518:	00fd87b3          	add	a5,s11,a5
    8000751c:	0007c683          	lbu	a3,0(a5)
    80007520:	00f00613          	li	a2,15
    80007524:	0007079b          	sext.w	a5,a4
    80007528:	f8d40023          	sb	a3,-128(s0)
    8000752c:	0047559b          	srliw	a1,a4,0x4
    80007530:	0047569b          	srliw	a3,a4,0x4
    80007534:	00000c93          	li	s9,0
    80007538:	0ee65063          	bge	a2,a4,80007618 <__printf+0x410>
    8000753c:	00f6f693          	andi	a3,a3,15
    80007540:	00dd86b3          	add	a3,s11,a3
    80007544:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007548:	0087d79b          	srliw	a5,a5,0x8
    8000754c:	00100c93          	li	s9,1
    80007550:	f8d400a3          	sb	a3,-127(s0)
    80007554:	0cb67263          	bgeu	a2,a1,80007618 <__printf+0x410>
    80007558:	00f7f693          	andi	a3,a5,15
    8000755c:	00dd86b3          	add	a3,s11,a3
    80007560:	0006c583          	lbu	a1,0(a3)
    80007564:	00f00613          	li	a2,15
    80007568:	0047d69b          	srliw	a3,a5,0x4
    8000756c:	f8b40123          	sb	a1,-126(s0)
    80007570:	0047d593          	srli	a1,a5,0x4
    80007574:	28f67e63          	bgeu	a2,a5,80007810 <__printf+0x608>
    80007578:	00f6f693          	andi	a3,a3,15
    8000757c:	00dd86b3          	add	a3,s11,a3
    80007580:	0006c503          	lbu	a0,0(a3)
    80007584:	0087d813          	srli	a6,a5,0x8
    80007588:	0087d69b          	srliw	a3,a5,0x8
    8000758c:	f8a401a3          	sb	a0,-125(s0)
    80007590:	28b67663          	bgeu	a2,a1,8000781c <__printf+0x614>
    80007594:	00f6f693          	andi	a3,a3,15
    80007598:	00dd86b3          	add	a3,s11,a3
    8000759c:	0006c583          	lbu	a1,0(a3)
    800075a0:	00c7d513          	srli	a0,a5,0xc
    800075a4:	00c7d69b          	srliw	a3,a5,0xc
    800075a8:	f8b40223          	sb	a1,-124(s0)
    800075ac:	29067a63          	bgeu	a2,a6,80007840 <__printf+0x638>
    800075b0:	00f6f693          	andi	a3,a3,15
    800075b4:	00dd86b3          	add	a3,s11,a3
    800075b8:	0006c583          	lbu	a1,0(a3)
    800075bc:	0107d813          	srli	a6,a5,0x10
    800075c0:	0107d69b          	srliw	a3,a5,0x10
    800075c4:	f8b402a3          	sb	a1,-123(s0)
    800075c8:	28a67263          	bgeu	a2,a0,8000784c <__printf+0x644>
    800075cc:	00f6f693          	andi	a3,a3,15
    800075d0:	00dd86b3          	add	a3,s11,a3
    800075d4:	0006c683          	lbu	a3,0(a3)
    800075d8:	0147d79b          	srliw	a5,a5,0x14
    800075dc:	f8d40323          	sb	a3,-122(s0)
    800075e0:	21067663          	bgeu	a2,a6,800077ec <__printf+0x5e4>
    800075e4:	02079793          	slli	a5,a5,0x20
    800075e8:	0207d793          	srli	a5,a5,0x20
    800075ec:	00fd8db3          	add	s11,s11,a5
    800075f0:	000dc683          	lbu	a3,0(s11)
    800075f4:	00800793          	li	a5,8
    800075f8:	00700c93          	li	s9,7
    800075fc:	f8d403a3          	sb	a3,-121(s0)
    80007600:	00075c63          	bgez	a4,80007618 <__printf+0x410>
    80007604:	f9040713          	addi	a4,s0,-112
    80007608:	00f70733          	add	a4,a4,a5
    8000760c:	02d00693          	li	a3,45
    80007610:	fed70823          	sb	a3,-16(a4)
    80007614:	00078c93          	mv	s9,a5
    80007618:	f8040793          	addi	a5,s0,-128
    8000761c:	01978cb3          	add	s9,a5,s9
    80007620:	f7f40d13          	addi	s10,s0,-129
    80007624:	000cc503          	lbu	a0,0(s9)
    80007628:	fffc8c93          	addi	s9,s9,-1
    8000762c:	00000097          	auipc	ra,0x0
    80007630:	9f8080e7          	jalr	-1544(ra) # 80007024 <consputc>
    80007634:	ff9d18e3          	bne	s10,s9,80007624 <__printf+0x41c>
    80007638:	0100006f          	j	80007648 <__printf+0x440>
    8000763c:	00000097          	auipc	ra,0x0
    80007640:	9e8080e7          	jalr	-1560(ra) # 80007024 <consputc>
    80007644:	000c8493          	mv	s1,s9
    80007648:	00094503          	lbu	a0,0(s2)
    8000764c:	c60510e3          	bnez	a0,800072ac <__printf+0xa4>
    80007650:	e40c0ee3          	beqz	s8,800074ac <__printf+0x2a4>
    80007654:	00005517          	auipc	a0,0x5
    80007658:	27c50513          	addi	a0,a0,636 # 8000c8d0 <pr>
    8000765c:	00001097          	auipc	ra,0x1
    80007660:	94c080e7          	jalr	-1716(ra) # 80007fa8 <release>
    80007664:	e49ff06f          	j	800074ac <__printf+0x2a4>
    80007668:	f7843783          	ld	a5,-136(s0)
    8000766c:	03000513          	li	a0,48
    80007670:	01000d13          	li	s10,16
    80007674:	00878713          	addi	a4,a5,8
    80007678:	0007bc83          	ld	s9,0(a5)
    8000767c:	f6e43c23          	sd	a4,-136(s0)
    80007680:	00000097          	auipc	ra,0x0
    80007684:	9a4080e7          	jalr	-1628(ra) # 80007024 <consputc>
    80007688:	07800513          	li	a0,120
    8000768c:	00000097          	auipc	ra,0x0
    80007690:	998080e7          	jalr	-1640(ra) # 80007024 <consputc>
    80007694:	00002d97          	auipc	s11,0x2
    80007698:	16cd8d93          	addi	s11,s11,364 # 80009800 <digits>
    8000769c:	03ccd793          	srli	a5,s9,0x3c
    800076a0:	00fd87b3          	add	a5,s11,a5
    800076a4:	0007c503          	lbu	a0,0(a5)
    800076a8:	fffd0d1b          	addiw	s10,s10,-1
    800076ac:	004c9c93          	slli	s9,s9,0x4
    800076b0:	00000097          	auipc	ra,0x0
    800076b4:	974080e7          	jalr	-1676(ra) # 80007024 <consputc>
    800076b8:	fe0d12e3          	bnez	s10,8000769c <__printf+0x494>
    800076bc:	f8dff06f          	j	80007648 <__printf+0x440>
    800076c0:	f7843783          	ld	a5,-136(s0)
    800076c4:	0007bc83          	ld	s9,0(a5)
    800076c8:	00878793          	addi	a5,a5,8
    800076cc:	f6f43c23          	sd	a5,-136(s0)
    800076d0:	000c9a63          	bnez	s9,800076e4 <__printf+0x4dc>
    800076d4:	1080006f          	j	800077dc <__printf+0x5d4>
    800076d8:	001c8c93          	addi	s9,s9,1
    800076dc:	00000097          	auipc	ra,0x0
    800076e0:	948080e7          	jalr	-1720(ra) # 80007024 <consputc>
    800076e4:	000cc503          	lbu	a0,0(s9)
    800076e8:	fe0518e3          	bnez	a0,800076d8 <__printf+0x4d0>
    800076ec:	f5dff06f          	j	80007648 <__printf+0x440>
    800076f0:	02500513          	li	a0,37
    800076f4:	00000097          	auipc	ra,0x0
    800076f8:	930080e7          	jalr	-1744(ra) # 80007024 <consputc>
    800076fc:	000c8513          	mv	a0,s9
    80007700:	00000097          	auipc	ra,0x0
    80007704:	924080e7          	jalr	-1756(ra) # 80007024 <consputc>
    80007708:	f41ff06f          	j	80007648 <__printf+0x440>
    8000770c:	02500513          	li	a0,37
    80007710:	00000097          	auipc	ra,0x0
    80007714:	914080e7          	jalr	-1772(ra) # 80007024 <consputc>
    80007718:	f31ff06f          	j	80007648 <__printf+0x440>
    8000771c:	00030513          	mv	a0,t1
    80007720:	00000097          	auipc	ra,0x0
    80007724:	7bc080e7          	jalr	1980(ra) # 80007edc <acquire>
    80007728:	b4dff06f          	j	80007274 <__printf+0x6c>
    8000772c:	40c0053b          	negw	a0,a2
    80007730:	00a00713          	li	a4,10
    80007734:	02e576bb          	remuw	a3,a0,a4
    80007738:	00002d97          	auipc	s11,0x2
    8000773c:	0c8d8d93          	addi	s11,s11,200 # 80009800 <digits>
    80007740:	ff700593          	li	a1,-9
    80007744:	02069693          	slli	a3,a3,0x20
    80007748:	0206d693          	srli	a3,a3,0x20
    8000774c:	00dd86b3          	add	a3,s11,a3
    80007750:	0006c683          	lbu	a3,0(a3)
    80007754:	02e557bb          	divuw	a5,a0,a4
    80007758:	f8d40023          	sb	a3,-128(s0)
    8000775c:	10b65e63          	bge	a2,a1,80007878 <__printf+0x670>
    80007760:	06300593          	li	a1,99
    80007764:	02e7f6bb          	remuw	a3,a5,a4
    80007768:	02069693          	slli	a3,a3,0x20
    8000776c:	0206d693          	srli	a3,a3,0x20
    80007770:	00dd86b3          	add	a3,s11,a3
    80007774:	0006c683          	lbu	a3,0(a3)
    80007778:	02e7d73b          	divuw	a4,a5,a4
    8000777c:	00200793          	li	a5,2
    80007780:	f8d400a3          	sb	a3,-127(s0)
    80007784:	bca5ece3          	bltu	a1,a0,8000735c <__printf+0x154>
    80007788:	ce5ff06f          	j	8000746c <__printf+0x264>
    8000778c:	40e007bb          	negw	a5,a4
    80007790:	00002d97          	auipc	s11,0x2
    80007794:	070d8d93          	addi	s11,s11,112 # 80009800 <digits>
    80007798:	00f7f693          	andi	a3,a5,15
    8000779c:	00dd86b3          	add	a3,s11,a3
    800077a0:	0006c583          	lbu	a1,0(a3)
    800077a4:	ff100613          	li	a2,-15
    800077a8:	0047d69b          	srliw	a3,a5,0x4
    800077ac:	f8b40023          	sb	a1,-128(s0)
    800077b0:	0047d59b          	srliw	a1,a5,0x4
    800077b4:	0ac75e63          	bge	a4,a2,80007870 <__printf+0x668>
    800077b8:	00f6f693          	andi	a3,a3,15
    800077bc:	00dd86b3          	add	a3,s11,a3
    800077c0:	0006c603          	lbu	a2,0(a3)
    800077c4:	00f00693          	li	a3,15
    800077c8:	0087d79b          	srliw	a5,a5,0x8
    800077cc:	f8c400a3          	sb	a2,-127(s0)
    800077d0:	d8b6e4e3          	bltu	a3,a1,80007558 <__printf+0x350>
    800077d4:	00200793          	li	a5,2
    800077d8:	e2dff06f          	j	80007604 <__printf+0x3fc>
    800077dc:	00002c97          	auipc	s9,0x2
    800077e0:	004c8c93          	addi	s9,s9,4 # 800097e0 <_ZTV9Semaphore+0x158>
    800077e4:	02800513          	li	a0,40
    800077e8:	ef1ff06f          	j	800076d8 <__printf+0x4d0>
    800077ec:	00700793          	li	a5,7
    800077f0:	00600c93          	li	s9,6
    800077f4:	e0dff06f          	j	80007600 <__printf+0x3f8>
    800077f8:	00700793          	li	a5,7
    800077fc:	00600c93          	li	s9,6
    80007800:	c69ff06f          	j	80007468 <__printf+0x260>
    80007804:	00300793          	li	a5,3
    80007808:	00200c93          	li	s9,2
    8000780c:	c5dff06f          	j	80007468 <__printf+0x260>
    80007810:	00300793          	li	a5,3
    80007814:	00200c93          	li	s9,2
    80007818:	de9ff06f          	j	80007600 <__printf+0x3f8>
    8000781c:	00400793          	li	a5,4
    80007820:	00300c93          	li	s9,3
    80007824:	dddff06f          	j	80007600 <__printf+0x3f8>
    80007828:	00400793          	li	a5,4
    8000782c:	00300c93          	li	s9,3
    80007830:	c39ff06f          	j	80007468 <__printf+0x260>
    80007834:	00500793          	li	a5,5
    80007838:	00400c93          	li	s9,4
    8000783c:	c2dff06f          	j	80007468 <__printf+0x260>
    80007840:	00500793          	li	a5,5
    80007844:	00400c93          	li	s9,4
    80007848:	db9ff06f          	j	80007600 <__printf+0x3f8>
    8000784c:	00600793          	li	a5,6
    80007850:	00500c93          	li	s9,5
    80007854:	dadff06f          	j	80007600 <__printf+0x3f8>
    80007858:	00600793          	li	a5,6
    8000785c:	00500c93          	li	s9,5
    80007860:	c09ff06f          	j	80007468 <__printf+0x260>
    80007864:	00800793          	li	a5,8
    80007868:	00700c93          	li	s9,7
    8000786c:	bfdff06f          	j	80007468 <__printf+0x260>
    80007870:	00100793          	li	a5,1
    80007874:	d91ff06f          	j	80007604 <__printf+0x3fc>
    80007878:	00100793          	li	a5,1
    8000787c:	bf1ff06f          	j	8000746c <__printf+0x264>
    80007880:	00900793          	li	a5,9
    80007884:	00800c93          	li	s9,8
    80007888:	be1ff06f          	j	80007468 <__printf+0x260>
    8000788c:	00002517          	auipc	a0,0x2
    80007890:	f5c50513          	addi	a0,a0,-164 # 800097e8 <_ZTV9Semaphore+0x160>
    80007894:	00000097          	auipc	ra,0x0
    80007898:	918080e7          	jalr	-1768(ra) # 800071ac <panic>

000000008000789c <printfinit>:
    8000789c:	fe010113          	addi	sp,sp,-32
    800078a0:	00813823          	sd	s0,16(sp)
    800078a4:	00913423          	sd	s1,8(sp)
    800078a8:	00113c23          	sd	ra,24(sp)
    800078ac:	02010413          	addi	s0,sp,32
    800078b0:	00005497          	auipc	s1,0x5
    800078b4:	02048493          	addi	s1,s1,32 # 8000c8d0 <pr>
    800078b8:	00048513          	mv	a0,s1
    800078bc:	00002597          	auipc	a1,0x2
    800078c0:	f3c58593          	addi	a1,a1,-196 # 800097f8 <_ZTV9Semaphore+0x170>
    800078c4:	00000097          	auipc	ra,0x0
    800078c8:	5f4080e7          	jalr	1524(ra) # 80007eb8 <initlock>
    800078cc:	01813083          	ld	ra,24(sp)
    800078d0:	01013403          	ld	s0,16(sp)
    800078d4:	0004ac23          	sw	zero,24(s1)
    800078d8:	00813483          	ld	s1,8(sp)
    800078dc:	02010113          	addi	sp,sp,32
    800078e0:	00008067          	ret

00000000800078e4 <uartinit>:
    800078e4:	ff010113          	addi	sp,sp,-16
    800078e8:	00813423          	sd	s0,8(sp)
    800078ec:	01010413          	addi	s0,sp,16
    800078f0:	100007b7          	lui	a5,0x10000
    800078f4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800078f8:	f8000713          	li	a4,-128
    800078fc:	00e781a3          	sb	a4,3(a5)
    80007900:	00300713          	li	a4,3
    80007904:	00e78023          	sb	a4,0(a5)
    80007908:	000780a3          	sb	zero,1(a5)
    8000790c:	00e781a3          	sb	a4,3(a5)
    80007910:	00700693          	li	a3,7
    80007914:	00d78123          	sb	a3,2(a5)
    80007918:	00e780a3          	sb	a4,1(a5)
    8000791c:	00813403          	ld	s0,8(sp)
    80007920:	01010113          	addi	sp,sp,16
    80007924:	00008067          	ret

0000000080007928 <uartputc>:
    80007928:	00004797          	auipc	a5,0x4
    8000792c:	d087a783          	lw	a5,-760(a5) # 8000b630 <panicked>
    80007930:	00078463          	beqz	a5,80007938 <uartputc+0x10>
    80007934:	0000006f          	j	80007934 <uartputc+0xc>
    80007938:	fd010113          	addi	sp,sp,-48
    8000793c:	02813023          	sd	s0,32(sp)
    80007940:	00913c23          	sd	s1,24(sp)
    80007944:	01213823          	sd	s2,16(sp)
    80007948:	01313423          	sd	s3,8(sp)
    8000794c:	02113423          	sd	ra,40(sp)
    80007950:	03010413          	addi	s0,sp,48
    80007954:	00004917          	auipc	s2,0x4
    80007958:	ce490913          	addi	s2,s2,-796 # 8000b638 <uart_tx_r>
    8000795c:	00093783          	ld	a5,0(s2)
    80007960:	00004497          	auipc	s1,0x4
    80007964:	ce048493          	addi	s1,s1,-800 # 8000b640 <uart_tx_w>
    80007968:	0004b703          	ld	a4,0(s1)
    8000796c:	02078693          	addi	a3,a5,32
    80007970:	00050993          	mv	s3,a0
    80007974:	02e69c63          	bne	a3,a4,800079ac <uartputc+0x84>
    80007978:	00001097          	auipc	ra,0x1
    8000797c:	834080e7          	jalr	-1996(ra) # 800081ac <push_on>
    80007980:	00093783          	ld	a5,0(s2)
    80007984:	0004b703          	ld	a4,0(s1)
    80007988:	02078793          	addi	a5,a5,32
    8000798c:	00e79463          	bne	a5,a4,80007994 <uartputc+0x6c>
    80007990:	0000006f          	j	80007990 <uartputc+0x68>
    80007994:	00001097          	auipc	ra,0x1
    80007998:	88c080e7          	jalr	-1908(ra) # 80008220 <pop_on>
    8000799c:	00093783          	ld	a5,0(s2)
    800079a0:	0004b703          	ld	a4,0(s1)
    800079a4:	02078693          	addi	a3,a5,32
    800079a8:	fce688e3          	beq	a3,a4,80007978 <uartputc+0x50>
    800079ac:	01f77693          	andi	a3,a4,31
    800079b0:	00005597          	auipc	a1,0x5
    800079b4:	f4058593          	addi	a1,a1,-192 # 8000c8f0 <uart_tx_buf>
    800079b8:	00d586b3          	add	a3,a1,a3
    800079bc:	00170713          	addi	a4,a4,1
    800079c0:	01368023          	sb	s3,0(a3)
    800079c4:	00e4b023          	sd	a4,0(s1)
    800079c8:	10000637          	lui	a2,0x10000
    800079cc:	02f71063          	bne	a4,a5,800079ec <uartputc+0xc4>
    800079d0:	0340006f          	j	80007a04 <uartputc+0xdc>
    800079d4:	00074703          	lbu	a4,0(a4)
    800079d8:	00f93023          	sd	a5,0(s2)
    800079dc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800079e0:	00093783          	ld	a5,0(s2)
    800079e4:	0004b703          	ld	a4,0(s1)
    800079e8:	00f70e63          	beq	a4,a5,80007a04 <uartputc+0xdc>
    800079ec:	00564683          	lbu	a3,5(a2)
    800079f0:	01f7f713          	andi	a4,a5,31
    800079f4:	00e58733          	add	a4,a1,a4
    800079f8:	0206f693          	andi	a3,a3,32
    800079fc:	00178793          	addi	a5,a5,1
    80007a00:	fc069ae3          	bnez	a3,800079d4 <uartputc+0xac>
    80007a04:	02813083          	ld	ra,40(sp)
    80007a08:	02013403          	ld	s0,32(sp)
    80007a0c:	01813483          	ld	s1,24(sp)
    80007a10:	01013903          	ld	s2,16(sp)
    80007a14:	00813983          	ld	s3,8(sp)
    80007a18:	03010113          	addi	sp,sp,48
    80007a1c:	00008067          	ret

0000000080007a20 <uartputc_sync>:
    80007a20:	ff010113          	addi	sp,sp,-16
    80007a24:	00813423          	sd	s0,8(sp)
    80007a28:	01010413          	addi	s0,sp,16
    80007a2c:	00004717          	auipc	a4,0x4
    80007a30:	c0472703          	lw	a4,-1020(a4) # 8000b630 <panicked>
    80007a34:	02071663          	bnez	a4,80007a60 <uartputc_sync+0x40>
    80007a38:	00050793          	mv	a5,a0
    80007a3c:	100006b7          	lui	a3,0x10000
    80007a40:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80007a44:	02077713          	andi	a4,a4,32
    80007a48:	fe070ce3          	beqz	a4,80007a40 <uartputc_sync+0x20>
    80007a4c:	0ff7f793          	andi	a5,a5,255
    80007a50:	00f68023          	sb	a5,0(a3)
    80007a54:	00813403          	ld	s0,8(sp)
    80007a58:	01010113          	addi	sp,sp,16
    80007a5c:	00008067          	ret
    80007a60:	0000006f          	j	80007a60 <uartputc_sync+0x40>

0000000080007a64 <uartstart>:
    80007a64:	ff010113          	addi	sp,sp,-16
    80007a68:	00813423          	sd	s0,8(sp)
    80007a6c:	01010413          	addi	s0,sp,16
    80007a70:	00004617          	auipc	a2,0x4
    80007a74:	bc860613          	addi	a2,a2,-1080 # 8000b638 <uart_tx_r>
    80007a78:	00004517          	auipc	a0,0x4
    80007a7c:	bc850513          	addi	a0,a0,-1080 # 8000b640 <uart_tx_w>
    80007a80:	00063783          	ld	a5,0(a2)
    80007a84:	00053703          	ld	a4,0(a0)
    80007a88:	04f70263          	beq	a4,a5,80007acc <uartstart+0x68>
    80007a8c:	100005b7          	lui	a1,0x10000
    80007a90:	00005817          	auipc	a6,0x5
    80007a94:	e6080813          	addi	a6,a6,-416 # 8000c8f0 <uart_tx_buf>
    80007a98:	01c0006f          	j	80007ab4 <uartstart+0x50>
    80007a9c:	0006c703          	lbu	a4,0(a3)
    80007aa0:	00f63023          	sd	a5,0(a2)
    80007aa4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007aa8:	00063783          	ld	a5,0(a2)
    80007aac:	00053703          	ld	a4,0(a0)
    80007ab0:	00f70e63          	beq	a4,a5,80007acc <uartstart+0x68>
    80007ab4:	01f7f713          	andi	a4,a5,31
    80007ab8:	00e806b3          	add	a3,a6,a4
    80007abc:	0055c703          	lbu	a4,5(a1)
    80007ac0:	00178793          	addi	a5,a5,1
    80007ac4:	02077713          	andi	a4,a4,32
    80007ac8:	fc071ae3          	bnez	a4,80007a9c <uartstart+0x38>
    80007acc:	00813403          	ld	s0,8(sp)
    80007ad0:	01010113          	addi	sp,sp,16
    80007ad4:	00008067          	ret

0000000080007ad8 <uartgetc>:
    80007ad8:	ff010113          	addi	sp,sp,-16
    80007adc:	00813423          	sd	s0,8(sp)
    80007ae0:	01010413          	addi	s0,sp,16
    80007ae4:	10000737          	lui	a4,0x10000
    80007ae8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80007aec:	0017f793          	andi	a5,a5,1
    80007af0:	00078c63          	beqz	a5,80007b08 <uartgetc+0x30>
    80007af4:	00074503          	lbu	a0,0(a4)
    80007af8:	0ff57513          	andi	a0,a0,255
    80007afc:	00813403          	ld	s0,8(sp)
    80007b00:	01010113          	addi	sp,sp,16
    80007b04:	00008067          	ret
    80007b08:	fff00513          	li	a0,-1
    80007b0c:	ff1ff06f          	j	80007afc <uartgetc+0x24>

0000000080007b10 <uartintr>:
    80007b10:	100007b7          	lui	a5,0x10000
    80007b14:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80007b18:	0017f793          	andi	a5,a5,1
    80007b1c:	0a078463          	beqz	a5,80007bc4 <uartintr+0xb4>
    80007b20:	fe010113          	addi	sp,sp,-32
    80007b24:	00813823          	sd	s0,16(sp)
    80007b28:	00913423          	sd	s1,8(sp)
    80007b2c:	00113c23          	sd	ra,24(sp)
    80007b30:	02010413          	addi	s0,sp,32
    80007b34:	100004b7          	lui	s1,0x10000
    80007b38:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80007b3c:	0ff57513          	andi	a0,a0,255
    80007b40:	fffff097          	auipc	ra,0xfffff
    80007b44:	534080e7          	jalr	1332(ra) # 80007074 <consoleintr>
    80007b48:	0054c783          	lbu	a5,5(s1)
    80007b4c:	0017f793          	andi	a5,a5,1
    80007b50:	fe0794e3          	bnez	a5,80007b38 <uartintr+0x28>
    80007b54:	00004617          	auipc	a2,0x4
    80007b58:	ae460613          	addi	a2,a2,-1308 # 8000b638 <uart_tx_r>
    80007b5c:	00004517          	auipc	a0,0x4
    80007b60:	ae450513          	addi	a0,a0,-1308 # 8000b640 <uart_tx_w>
    80007b64:	00063783          	ld	a5,0(a2)
    80007b68:	00053703          	ld	a4,0(a0)
    80007b6c:	04f70263          	beq	a4,a5,80007bb0 <uartintr+0xa0>
    80007b70:	100005b7          	lui	a1,0x10000
    80007b74:	00005817          	auipc	a6,0x5
    80007b78:	d7c80813          	addi	a6,a6,-644 # 8000c8f0 <uart_tx_buf>
    80007b7c:	01c0006f          	j	80007b98 <uartintr+0x88>
    80007b80:	0006c703          	lbu	a4,0(a3)
    80007b84:	00f63023          	sd	a5,0(a2)
    80007b88:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007b8c:	00063783          	ld	a5,0(a2)
    80007b90:	00053703          	ld	a4,0(a0)
    80007b94:	00f70e63          	beq	a4,a5,80007bb0 <uartintr+0xa0>
    80007b98:	01f7f713          	andi	a4,a5,31
    80007b9c:	00e806b3          	add	a3,a6,a4
    80007ba0:	0055c703          	lbu	a4,5(a1)
    80007ba4:	00178793          	addi	a5,a5,1
    80007ba8:	02077713          	andi	a4,a4,32
    80007bac:	fc071ae3          	bnez	a4,80007b80 <uartintr+0x70>
    80007bb0:	01813083          	ld	ra,24(sp)
    80007bb4:	01013403          	ld	s0,16(sp)
    80007bb8:	00813483          	ld	s1,8(sp)
    80007bbc:	02010113          	addi	sp,sp,32
    80007bc0:	00008067          	ret
    80007bc4:	00004617          	auipc	a2,0x4
    80007bc8:	a7460613          	addi	a2,a2,-1420 # 8000b638 <uart_tx_r>
    80007bcc:	00004517          	auipc	a0,0x4
    80007bd0:	a7450513          	addi	a0,a0,-1420 # 8000b640 <uart_tx_w>
    80007bd4:	00063783          	ld	a5,0(a2)
    80007bd8:	00053703          	ld	a4,0(a0)
    80007bdc:	04f70263          	beq	a4,a5,80007c20 <uartintr+0x110>
    80007be0:	100005b7          	lui	a1,0x10000
    80007be4:	00005817          	auipc	a6,0x5
    80007be8:	d0c80813          	addi	a6,a6,-756 # 8000c8f0 <uart_tx_buf>
    80007bec:	01c0006f          	j	80007c08 <uartintr+0xf8>
    80007bf0:	0006c703          	lbu	a4,0(a3)
    80007bf4:	00f63023          	sd	a5,0(a2)
    80007bf8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007bfc:	00063783          	ld	a5,0(a2)
    80007c00:	00053703          	ld	a4,0(a0)
    80007c04:	02f70063          	beq	a4,a5,80007c24 <uartintr+0x114>
    80007c08:	01f7f713          	andi	a4,a5,31
    80007c0c:	00e806b3          	add	a3,a6,a4
    80007c10:	0055c703          	lbu	a4,5(a1)
    80007c14:	00178793          	addi	a5,a5,1
    80007c18:	02077713          	andi	a4,a4,32
    80007c1c:	fc071ae3          	bnez	a4,80007bf0 <uartintr+0xe0>
    80007c20:	00008067          	ret
    80007c24:	00008067          	ret

0000000080007c28 <kinit>:
    80007c28:	fc010113          	addi	sp,sp,-64
    80007c2c:	02913423          	sd	s1,40(sp)
    80007c30:	fffff7b7          	lui	a5,0xfffff
    80007c34:	00006497          	auipc	s1,0x6
    80007c38:	cdb48493          	addi	s1,s1,-805 # 8000d90f <end+0xfff>
    80007c3c:	02813823          	sd	s0,48(sp)
    80007c40:	01313c23          	sd	s3,24(sp)
    80007c44:	00f4f4b3          	and	s1,s1,a5
    80007c48:	02113c23          	sd	ra,56(sp)
    80007c4c:	03213023          	sd	s2,32(sp)
    80007c50:	01413823          	sd	s4,16(sp)
    80007c54:	01513423          	sd	s5,8(sp)
    80007c58:	04010413          	addi	s0,sp,64
    80007c5c:	000017b7          	lui	a5,0x1
    80007c60:	01100993          	li	s3,17
    80007c64:	00f487b3          	add	a5,s1,a5
    80007c68:	01b99993          	slli	s3,s3,0x1b
    80007c6c:	06f9e063          	bltu	s3,a5,80007ccc <kinit+0xa4>
    80007c70:	00005a97          	auipc	s5,0x5
    80007c74:	ca0a8a93          	addi	s5,s5,-864 # 8000c910 <end>
    80007c78:	0754ec63          	bltu	s1,s5,80007cf0 <kinit+0xc8>
    80007c7c:	0734fa63          	bgeu	s1,s3,80007cf0 <kinit+0xc8>
    80007c80:	00088a37          	lui	s4,0x88
    80007c84:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80007c88:	00004917          	auipc	s2,0x4
    80007c8c:	9c090913          	addi	s2,s2,-1600 # 8000b648 <kmem>
    80007c90:	00ca1a13          	slli	s4,s4,0xc
    80007c94:	0140006f          	j	80007ca8 <kinit+0x80>
    80007c98:	000017b7          	lui	a5,0x1
    80007c9c:	00f484b3          	add	s1,s1,a5
    80007ca0:	0554e863          	bltu	s1,s5,80007cf0 <kinit+0xc8>
    80007ca4:	0534f663          	bgeu	s1,s3,80007cf0 <kinit+0xc8>
    80007ca8:	00001637          	lui	a2,0x1
    80007cac:	00100593          	li	a1,1
    80007cb0:	00048513          	mv	a0,s1
    80007cb4:	00000097          	auipc	ra,0x0
    80007cb8:	5e4080e7          	jalr	1508(ra) # 80008298 <__memset>
    80007cbc:	00093783          	ld	a5,0(s2)
    80007cc0:	00f4b023          	sd	a5,0(s1)
    80007cc4:	00993023          	sd	s1,0(s2)
    80007cc8:	fd4498e3          	bne	s1,s4,80007c98 <kinit+0x70>
    80007ccc:	03813083          	ld	ra,56(sp)
    80007cd0:	03013403          	ld	s0,48(sp)
    80007cd4:	02813483          	ld	s1,40(sp)
    80007cd8:	02013903          	ld	s2,32(sp)
    80007cdc:	01813983          	ld	s3,24(sp)
    80007ce0:	01013a03          	ld	s4,16(sp)
    80007ce4:	00813a83          	ld	s5,8(sp)
    80007ce8:	04010113          	addi	sp,sp,64
    80007cec:	00008067          	ret
    80007cf0:	00002517          	auipc	a0,0x2
    80007cf4:	b2850513          	addi	a0,a0,-1240 # 80009818 <digits+0x18>
    80007cf8:	fffff097          	auipc	ra,0xfffff
    80007cfc:	4b4080e7          	jalr	1204(ra) # 800071ac <panic>

0000000080007d00 <freerange>:
    80007d00:	fc010113          	addi	sp,sp,-64
    80007d04:	000017b7          	lui	a5,0x1
    80007d08:	02913423          	sd	s1,40(sp)
    80007d0c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80007d10:	009504b3          	add	s1,a0,s1
    80007d14:	fffff537          	lui	a0,0xfffff
    80007d18:	02813823          	sd	s0,48(sp)
    80007d1c:	02113c23          	sd	ra,56(sp)
    80007d20:	03213023          	sd	s2,32(sp)
    80007d24:	01313c23          	sd	s3,24(sp)
    80007d28:	01413823          	sd	s4,16(sp)
    80007d2c:	01513423          	sd	s5,8(sp)
    80007d30:	01613023          	sd	s6,0(sp)
    80007d34:	04010413          	addi	s0,sp,64
    80007d38:	00a4f4b3          	and	s1,s1,a0
    80007d3c:	00f487b3          	add	a5,s1,a5
    80007d40:	06f5e463          	bltu	a1,a5,80007da8 <freerange+0xa8>
    80007d44:	00005a97          	auipc	s5,0x5
    80007d48:	bcca8a93          	addi	s5,s5,-1076 # 8000c910 <end>
    80007d4c:	0954e263          	bltu	s1,s5,80007dd0 <freerange+0xd0>
    80007d50:	01100993          	li	s3,17
    80007d54:	01b99993          	slli	s3,s3,0x1b
    80007d58:	0734fc63          	bgeu	s1,s3,80007dd0 <freerange+0xd0>
    80007d5c:	00058a13          	mv	s4,a1
    80007d60:	00004917          	auipc	s2,0x4
    80007d64:	8e890913          	addi	s2,s2,-1816 # 8000b648 <kmem>
    80007d68:	00002b37          	lui	s6,0x2
    80007d6c:	0140006f          	j	80007d80 <freerange+0x80>
    80007d70:	000017b7          	lui	a5,0x1
    80007d74:	00f484b3          	add	s1,s1,a5
    80007d78:	0554ec63          	bltu	s1,s5,80007dd0 <freerange+0xd0>
    80007d7c:	0534fa63          	bgeu	s1,s3,80007dd0 <freerange+0xd0>
    80007d80:	00001637          	lui	a2,0x1
    80007d84:	00100593          	li	a1,1
    80007d88:	00048513          	mv	a0,s1
    80007d8c:	00000097          	auipc	ra,0x0
    80007d90:	50c080e7          	jalr	1292(ra) # 80008298 <__memset>
    80007d94:	00093703          	ld	a4,0(s2)
    80007d98:	016487b3          	add	a5,s1,s6
    80007d9c:	00e4b023          	sd	a4,0(s1)
    80007da0:	00993023          	sd	s1,0(s2)
    80007da4:	fcfa76e3          	bgeu	s4,a5,80007d70 <freerange+0x70>
    80007da8:	03813083          	ld	ra,56(sp)
    80007dac:	03013403          	ld	s0,48(sp)
    80007db0:	02813483          	ld	s1,40(sp)
    80007db4:	02013903          	ld	s2,32(sp)
    80007db8:	01813983          	ld	s3,24(sp)
    80007dbc:	01013a03          	ld	s4,16(sp)
    80007dc0:	00813a83          	ld	s5,8(sp)
    80007dc4:	00013b03          	ld	s6,0(sp)
    80007dc8:	04010113          	addi	sp,sp,64
    80007dcc:	00008067          	ret
    80007dd0:	00002517          	auipc	a0,0x2
    80007dd4:	a4850513          	addi	a0,a0,-1464 # 80009818 <digits+0x18>
    80007dd8:	fffff097          	auipc	ra,0xfffff
    80007ddc:	3d4080e7          	jalr	980(ra) # 800071ac <panic>

0000000080007de0 <kfree>:
    80007de0:	fe010113          	addi	sp,sp,-32
    80007de4:	00813823          	sd	s0,16(sp)
    80007de8:	00113c23          	sd	ra,24(sp)
    80007dec:	00913423          	sd	s1,8(sp)
    80007df0:	02010413          	addi	s0,sp,32
    80007df4:	03451793          	slli	a5,a0,0x34
    80007df8:	04079c63          	bnez	a5,80007e50 <kfree+0x70>
    80007dfc:	00005797          	auipc	a5,0x5
    80007e00:	b1478793          	addi	a5,a5,-1260 # 8000c910 <end>
    80007e04:	00050493          	mv	s1,a0
    80007e08:	04f56463          	bltu	a0,a5,80007e50 <kfree+0x70>
    80007e0c:	01100793          	li	a5,17
    80007e10:	01b79793          	slli	a5,a5,0x1b
    80007e14:	02f57e63          	bgeu	a0,a5,80007e50 <kfree+0x70>
    80007e18:	00001637          	lui	a2,0x1
    80007e1c:	00100593          	li	a1,1
    80007e20:	00000097          	auipc	ra,0x0
    80007e24:	478080e7          	jalr	1144(ra) # 80008298 <__memset>
    80007e28:	00004797          	auipc	a5,0x4
    80007e2c:	82078793          	addi	a5,a5,-2016 # 8000b648 <kmem>
    80007e30:	0007b703          	ld	a4,0(a5)
    80007e34:	01813083          	ld	ra,24(sp)
    80007e38:	01013403          	ld	s0,16(sp)
    80007e3c:	00e4b023          	sd	a4,0(s1)
    80007e40:	0097b023          	sd	s1,0(a5)
    80007e44:	00813483          	ld	s1,8(sp)
    80007e48:	02010113          	addi	sp,sp,32
    80007e4c:	00008067          	ret
    80007e50:	00002517          	auipc	a0,0x2
    80007e54:	9c850513          	addi	a0,a0,-1592 # 80009818 <digits+0x18>
    80007e58:	fffff097          	auipc	ra,0xfffff
    80007e5c:	354080e7          	jalr	852(ra) # 800071ac <panic>

0000000080007e60 <kalloc>:
    80007e60:	fe010113          	addi	sp,sp,-32
    80007e64:	00813823          	sd	s0,16(sp)
    80007e68:	00913423          	sd	s1,8(sp)
    80007e6c:	00113c23          	sd	ra,24(sp)
    80007e70:	02010413          	addi	s0,sp,32
    80007e74:	00003797          	auipc	a5,0x3
    80007e78:	7d478793          	addi	a5,a5,2004 # 8000b648 <kmem>
    80007e7c:	0007b483          	ld	s1,0(a5)
    80007e80:	02048063          	beqz	s1,80007ea0 <kalloc+0x40>
    80007e84:	0004b703          	ld	a4,0(s1)
    80007e88:	00001637          	lui	a2,0x1
    80007e8c:	00500593          	li	a1,5
    80007e90:	00048513          	mv	a0,s1
    80007e94:	00e7b023          	sd	a4,0(a5)
    80007e98:	00000097          	auipc	ra,0x0
    80007e9c:	400080e7          	jalr	1024(ra) # 80008298 <__memset>
    80007ea0:	01813083          	ld	ra,24(sp)
    80007ea4:	01013403          	ld	s0,16(sp)
    80007ea8:	00048513          	mv	a0,s1
    80007eac:	00813483          	ld	s1,8(sp)
    80007eb0:	02010113          	addi	sp,sp,32
    80007eb4:	00008067          	ret

0000000080007eb8 <initlock>:
    80007eb8:	ff010113          	addi	sp,sp,-16
    80007ebc:	00813423          	sd	s0,8(sp)
    80007ec0:	01010413          	addi	s0,sp,16
    80007ec4:	00813403          	ld	s0,8(sp)
    80007ec8:	00b53423          	sd	a1,8(a0)
    80007ecc:	00052023          	sw	zero,0(a0)
    80007ed0:	00053823          	sd	zero,16(a0)
    80007ed4:	01010113          	addi	sp,sp,16
    80007ed8:	00008067          	ret

0000000080007edc <acquire>:
    80007edc:	fe010113          	addi	sp,sp,-32
    80007ee0:	00813823          	sd	s0,16(sp)
    80007ee4:	00913423          	sd	s1,8(sp)
    80007ee8:	00113c23          	sd	ra,24(sp)
    80007eec:	01213023          	sd	s2,0(sp)
    80007ef0:	02010413          	addi	s0,sp,32
    80007ef4:	00050493          	mv	s1,a0
    80007ef8:	10002973          	csrr	s2,sstatus
    80007efc:	100027f3          	csrr	a5,sstatus
    80007f00:	ffd7f793          	andi	a5,a5,-3
    80007f04:	10079073          	csrw	sstatus,a5
    80007f08:	fffff097          	auipc	ra,0xfffff
    80007f0c:	8e4080e7          	jalr	-1820(ra) # 800067ec <mycpu>
    80007f10:	07852783          	lw	a5,120(a0)
    80007f14:	06078e63          	beqz	a5,80007f90 <acquire+0xb4>
    80007f18:	fffff097          	auipc	ra,0xfffff
    80007f1c:	8d4080e7          	jalr	-1836(ra) # 800067ec <mycpu>
    80007f20:	07852783          	lw	a5,120(a0)
    80007f24:	0004a703          	lw	a4,0(s1)
    80007f28:	0017879b          	addiw	a5,a5,1
    80007f2c:	06f52c23          	sw	a5,120(a0)
    80007f30:	04071063          	bnez	a4,80007f70 <acquire+0x94>
    80007f34:	00100713          	li	a4,1
    80007f38:	00070793          	mv	a5,a4
    80007f3c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80007f40:	0007879b          	sext.w	a5,a5
    80007f44:	fe079ae3          	bnez	a5,80007f38 <acquire+0x5c>
    80007f48:	0ff0000f          	fence
    80007f4c:	fffff097          	auipc	ra,0xfffff
    80007f50:	8a0080e7          	jalr	-1888(ra) # 800067ec <mycpu>
    80007f54:	01813083          	ld	ra,24(sp)
    80007f58:	01013403          	ld	s0,16(sp)
    80007f5c:	00a4b823          	sd	a0,16(s1)
    80007f60:	00013903          	ld	s2,0(sp)
    80007f64:	00813483          	ld	s1,8(sp)
    80007f68:	02010113          	addi	sp,sp,32
    80007f6c:	00008067          	ret
    80007f70:	0104b903          	ld	s2,16(s1)
    80007f74:	fffff097          	auipc	ra,0xfffff
    80007f78:	878080e7          	jalr	-1928(ra) # 800067ec <mycpu>
    80007f7c:	faa91ce3          	bne	s2,a0,80007f34 <acquire+0x58>
    80007f80:	00002517          	auipc	a0,0x2
    80007f84:	8a050513          	addi	a0,a0,-1888 # 80009820 <digits+0x20>
    80007f88:	fffff097          	auipc	ra,0xfffff
    80007f8c:	224080e7          	jalr	548(ra) # 800071ac <panic>
    80007f90:	00195913          	srli	s2,s2,0x1
    80007f94:	fffff097          	auipc	ra,0xfffff
    80007f98:	858080e7          	jalr	-1960(ra) # 800067ec <mycpu>
    80007f9c:	00197913          	andi	s2,s2,1
    80007fa0:	07252e23          	sw	s2,124(a0)
    80007fa4:	f75ff06f          	j	80007f18 <acquire+0x3c>

0000000080007fa8 <release>:
    80007fa8:	fe010113          	addi	sp,sp,-32
    80007fac:	00813823          	sd	s0,16(sp)
    80007fb0:	00113c23          	sd	ra,24(sp)
    80007fb4:	00913423          	sd	s1,8(sp)
    80007fb8:	01213023          	sd	s2,0(sp)
    80007fbc:	02010413          	addi	s0,sp,32
    80007fc0:	00052783          	lw	a5,0(a0)
    80007fc4:	00079a63          	bnez	a5,80007fd8 <release+0x30>
    80007fc8:	00002517          	auipc	a0,0x2
    80007fcc:	86050513          	addi	a0,a0,-1952 # 80009828 <digits+0x28>
    80007fd0:	fffff097          	auipc	ra,0xfffff
    80007fd4:	1dc080e7          	jalr	476(ra) # 800071ac <panic>
    80007fd8:	01053903          	ld	s2,16(a0)
    80007fdc:	00050493          	mv	s1,a0
    80007fe0:	fffff097          	auipc	ra,0xfffff
    80007fe4:	80c080e7          	jalr	-2036(ra) # 800067ec <mycpu>
    80007fe8:	fea910e3          	bne	s2,a0,80007fc8 <release+0x20>
    80007fec:	0004b823          	sd	zero,16(s1)
    80007ff0:	0ff0000f          	fence
    80007ff4:	0f50000f          	fence	iorw,ow
    80007ff8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80007ffc:	ffffe097          	auipc	ra,0xffffe
    80008000:	7f0080e7          	jalr	2032(ra) # 800067ec <mycpu>
    80008004:	100027f3          	csrr	a5,sstatus
    80008008:	0027f793          	andi	a5,a5,2
    8000800c:	04079a63          	bnez	a5,80008060 <release+0xb8>
    80008010:	07852783          	lw	a5,120(a0)
    80008014:	02f05e63          	blez	a5,80008050 <release+0xa8>
    80008018:	fff7871b          	addiw	a4,a5,-1
    8000801c:	06e52c23          	sw	a4,120(a0)
    80008020:	00071c63          	bnez	a4,80008038 <release+0x90>
    80008024:	07c52783          	lw	a5,124(a0)
    80008028:	00078863          	beqz	a5,80008038 <release+0x90>
    8000802c:	100027f3          	csrr	a5,sstatus
    80008030:	0027e793          	ori	a5,a5,2
    80008034:	10079073          	csrw	sstatus,a5
    80008038:	01813083          	ld	ra,24(sp)
    8000803c:	01013403          	ld	s0,16(sp)
    80008040:	00813483          	ld	s1,8(sp)
    80008044:	00013903          	ld	s2,0(sp)
    80008048:	02010113          	addi	sp,sp,32
    8000804c:	00008067          	ret
    80008050:	00001517          	auipc	a0,0x1
    80008054:	7f850513          	addi	a0,a0,2040 # 80009848 <digits+0x48>
    80008058:	fffff097          	auipc	ra,0xfffff
    8000805c:	154080e7          	jalr	340(ra) # 800071ac <panic>
    80008060:	00001517          	auipc	a0,0x1
    80008064:	7d050513          	addi	a0,a0,2000 # 80009830 <digits+0x30>
    80008068:	fffff097          	auipc	ra,0xfffff
    8000806c:	144080e7          	jalr	324(ra) # 800071ac <panic>

0000000080008070 <holding>:
    80008070:	00052783          	lw	a5,0(a0)
    80008074:	00079663          	bnez	a5,80008080 <holding+0x10>
    80008078:	00000513          	li	a0,0
    8000807c:	00008067          	ret
    80008080:	fe010113          	addi	sp,sp,-32
    80008084:	00813823          	sd	s0,16(sp)
    80008088:	00913423          	sd	s1,8(sp)
    8000808c:	00113c23          	sd	ra,24(sp)
    80008090:	02010413          	addi	s0,sp,32
    80008094:	01053483          	ld	s1,16(a0)
    80008098:	ffffe097          	auipc	ra,0xffffe
    8000809c:	754080e7          	jalr	1876(ra) # 800067ec <mycpu>
    800080a0:	01813083          	ld	ra,24(sp)
    800080a4:	01013403          	ld	s0,16(sp)
    800080a8:	40a48533          	sub	a0,s1,a0
    800080ac:	00153513          	seqz	a0,a0
    800080b0:	00813483          	ld	s1,8(sp)
    800080b4:	02010113          	addi	sp,sp,32
    800080b8:	00008067          	ret

00000000800080bc <push_off>:
    800080bc:	fe010113          	addi	sp,sp,-32
    800080c0:	00813823          	sd	s0,16(sp)
    800080c4:	00113c23          	sd	ra,24(sp)
    800080c8:	00913423          	sd	s1,8(sp)
    800080cc:	02010413          	addi	s0,sp,32
    800080d0:	100024f3          	csrr	s1,sstatus
    800080d4:	100027f3          	csrr	a5,sstatus
    800080d8:	ffd7f793          	andi	a5,a5,-3
    800080dc:	10079073          	csrw	sstatus,a5
    800080e0:	ffffe097          	auipc	ra,0xffffe
    800080e4:	70c080e7          	jalr	1804(ra) # 800067ec <mycpu>
    800080e8:	07852783          	lw	a5,120(a0)
    800080ec:	02078663          	beqz	a5,80008118 <push_off+0x5c>
    800080f0:	ffffe097          	auipc	ra,0xffffe
    800080f4:	6fc080e7          	jalr	1788(ra) # 800067ec <mycpu>
    800080f8:	07852783          	lw	a5,120(a0)
    800080fc:	01813083          	ld	ra,24(sp)
    80008100:	01013403          	ld	s0,16(sp)
    80008104:	0017879b          	addiw	a5,a5,1
    80008108:	06f52c23          	sw	a5,120(a0)
    8000810c:	00813483          	ld	s1,8(sp)
    80008110:	02010113          	addi	sp,sp,32
    80008114:	00008067          	ret
    80008118:	0014d493          	srli	s1,s1,0x1
    8000811c:	ffffe097          	auipc	ra,0xffffe
    80008120:	6d0080e7          	jalr	1744(ra) # 800067ec <mycpu>
    80008124:	0014f493          	andi	s1,s1,1
    80008128:	06952e23          	sw	s1,124(a0)
    8000812c:	fc5ff06f          	j	800080f0 <push_off+0x34>

0000000080008130 <pop_off>:
    80008130:	ff010113          	addi	sp,sp,-16
    80008134:	00813023          	sd	s0,0(sp)
    80008138:	00113423          	sd	ra,8(sp)
    8000813c:	01010413          	addi	s0,sp,16
    80008140:	ffffe097          	auipc	ra,0xffffe
    80008144:	6ac080e7          	jalr	1708(ra) # 800067ec <mycpu>
    80008148:	100027f3          	csrr	a5,sstatus
    8000814c:	0027f793          	andi	a5,a5,2
    80008150:	04079663          	bnez	a5,8000819c <pop_off+0x6c>
    80008154:	07852783          	lw	a5,120(a0)
    80008158:	02f05a63          	blez	a5,8000818c <pop_off+0x5c>
    8000815c:	fff7871b          	addiw	a4,a5,-1
    80008160:	06e52c23          	sw	a4,120(a0)
    80008164:	00071c63          	bnez	a4,8000817c <pop_off+0x4c>
    80008168:	07c52783          	lw	a5,124(a0)
    8000816c:	00078863          	beqz	a5,8000817c <pop_off+0x4c>
    80008170:	100027f3          	csrr	a5,sstatus
    80008174:	0027e793          	ori	a5,a5,2
    80008178:	10079073          	csrw	sstatus,a5
    8000817c:	00813083          	ld	ra,8(sp)
    80008180:	00013403          	ld	s0,0(sp)
    80008184:	01010113          	addi	sp,sp,16
    80008188:	00008067          	ret
    8000818c:	00001517          	auipc	a0,0x1
    80008190:	6bc50513          	addi	a0,a0,1724 # 80009848 <digits+0x48>
    80008194:	fffff097          	auipc	ra,0xfffff
    80008198:	018080e7          	jalr	24(ra) # 800071ac <panic>
    8000819c:	00001517          	auipc	a0,0x1
    800081a0:	69450513          	addi	a0,a0,1684 # 80009830 <digits+0x30>
    800081a4:	fffff097          	auipc	ra,0xfffff
    800081a8:	008080e7          	jalr	8(ra) # 800071ac <panic>

00000000800081ac <push_on>:
    800081ac:	fe010113          	addi	sp,sp,-32
    800081b0:	00813823          	sd	s0,16(sp)
    800081b4:	00113c23          	sd	ra,24(sp)
    800081b8:	00913423          	sd	s1,8(sp)
    800081bc:	02010413          	addi	s0,sp,32
    800081c0:	100024f3          	csrr	s1,sstatus
    800081c4:	100027f3          	csrr	a5,sstatus
    800081c8:	0027e793          	ori	a5,a5,2
    800081cc:	10079073          	csrw	sstatus,a5
    800081d0:	ffffe097          	auipc	ra,0xffffe
    800081d4:	61c080e7          	jalr	1564(ra) # 800067ec <mycpu>
    800081d8:	07852783          	lw	a5,120(a0)
    800081dc:	02078663          	beqz	a5,80008208 <push_on+0x5c>
    800081e0:	ffffe097          	auipc	ra,0xffffe
    800081e4:	60c080e7          	jalr	1548(ra) # 800067ec <mycpu>
    800081e8:	07852783          	lw	a5,120(a0)
    800081ec:	01813083          	ld	ra,24(sp)
    800081f0:	01013403          	ld	s0,16(sp)
    800081f4:	0017879b          	addiw	a5,a5,1
    800081f8:	06f52c23          	sw	a5,120(a0)
    800081fc:	00813483          	ld	s1,8(sp)
    80008200:	02010113          	addi	sp,sp,32
    80008204:	00008067          	ret
    80008208:	0014d493          	srli	s1,s1,0x1
    8000820c:	ffffe097          	auipc	ra,0xffffe
    80008210:	5e0080e7          	jalr	1504(ra) # 800067ec <mycpu>
    80008214:	0014f493          	andi	s1,s1,1
    80008218:	06952e23          	sw	s1,124(a0)
    8000821c:	fc5ff06f          	j	800081e0 <push_on+0x34>

0000000080008220 <pop_on>:
    80008220:	ff010113          	addi	sp,sp,-16
    80008224:	00813023          	sd	s0,0(sp)
    80008228:	00113423          	sd	ra,8(sp)
    8000822c:	01010413          	addi	s0,sp,16
    80008230:	ffffe097          	auipc	ra,0xffffe
    80008234:	5bc080e7          	jalr	1468(ra) # 800067ec <mycpu>
    80008238:	100027f3          	csrr	a5,sstatus
    8000823c:	0027f793          	andi	a5,a5,2
    80008240:	04078463          	beqz	a5,80008288 <pop_on+0x68>
    80008244:	07852783          	lw	a5,120(a0)
    80008248:	02f05863          	blez	a5,80008278 <pop_on+0x58>
    8000824c:	fff7879b          	addiw	a5,a5,-1
    80008250:	06f52c23          	sw	a5,120(a0)
    80008254:	07853783          	ld	a5,120(a0)
    80008258:	00079863          	bnez	a5,80008268 <pop_on+0x48>
    8000825c:	100027f3          	csrr	a5,sstatus
    80008260:	ffd7f793          	andi	a5,a5,-3
    80008264:	10079073          	csrw	sstatus,a5
    80008268:	00813083          	ld	ra,8(sp)
    8000826c:	00013403          	ld	s0,0(sp)
    80008270:	01010113          	addi	sp,sp,16
    80008274:	00008067          	ret
    80008278:	00001517          	auipc	a0,0x1
    8000827c:	5f850513          	addi	a0,a0,1528 # 80009870 <digits+0x70>
    80008280:	fffff097          	auipc	ra,0xfffff
    80008284:	f2c080e7          	jalr	-212(ra) # 800071ac <panic>
    80008288:	00001517          	auipc	a0,0x1
    8000828c:	5c850513          	addi	a0,a0,1480 # 80009850 <digits+0x50>
    80008290:	fffff097          	auipc	ra,0xfffff
    80008294:	f1c080e7          	jalr	-228(ra) # 800071ac <panic>

0000000080008298 <__memset>:
    80008298:	ff010113          	addi	sp,sp,-16
    8000829c:	00813423          	sd	s0,8(sp)
    800082a0:	01010413          	addi	s0,sp,16
    800082a4:	1a060e63          	beqz	a2,80008460 <__memset+0x1c8>
    800082a8:	40a007b3          	neg	a5,a0
    800082ac:	0077f793          	andi	a5,a5,7
    800082b0:	00778693          	addi	a3,a5,7
    800082b4:	00b00813          	li	a6,11
    800082b8:	0ff5f593          	andi	a1,a1,255
    800082bc:	fff6071b          	addiw	a4,a2,-1
    800082c0:	1b06e663          	bltu	a3,a6,8000846c <__memset+0x1d4>
    800082c4:	1cd76463          	bltu	a4,a3,8000848c <__memset+0x1f4>
    800082c8:	1a078e63          	beqz	a5,80008484 <__memset+0x1ec>
    800082cc:	00b50023          	sb	a1,0(a0)
    800082d0:	00100713          	li	a4,1
    800082d4:	1ae78463          	beq	a5,a4,8000847c <__memset+0x1e4>
    800082d8:	00b500a3          	sb	a1,1(a0)
    800082dc:	00200713          	li	a4,2
    800082e0:	1ae78a63          	beq	a5,a4,80008494 <__memset+0x1fc>
    800082e4:	00b50123          	sb	a1,2(a0)
    800082e8:	00300713          	li	a4,3
    800082ec:	18e78463          	beq	a5,a4,80008474 <__memset+0x1dc>
    800082f0:	00b501a3          	sb	a1,3(a0)
    800082f4:	00400713          	li	a4,4
    800082f8:	1ae78263          	beq	a5,a4,8000849c <__memset+0x204>
    800082fc:	00b50223          	sb	a1,4(a0)
    80008300:	00500713          	li	a4,5
    80008304:	1ae78063          	beq	a5,a4,800084a4 <__memset+0x20c>
    80008308:	00b502a3          	sb	a1,5(a0)
    8000830c:	00700713          	li	a4,7
    80008310:	18e79e63          	bne	a5,a4,800084ac <__memset+0x214>
    80008314:	00b50323          	sb	a1,6(a0)
    80008318:	00700e93          	li	t4,7
    8000831c:	00859713          	slli	a4,a1,0x8
    80008320:	00e5e733          	or	a4,a1,a4
    80008324:	01059e13          	slli	t3,a1,0x10
    80008328:	01c76e33          	or	t3,a4,t3
    8000832c:	01859313          	slli	t1,a1,0x18
    80008330:	006e6333          	or	t1,t3,t1
    80008334:	02059893          	slli	a7,a1,0x20
    80008338:	40f60e3b          	subw	t3,a2,a5
    8000833c:	011368b3          	or	a7,t1,a7
    80008340:	02859813          	slli	a6,a1,0x28
    80008344:	0108e833          	or	a6,a7,a6
    80008348:	03059693          	slli	a3,a1,0x30
    8000834c:	003e589b          	srliw	a7,t3,0x3
    80008350:	00d866b3          	or	a3,a6,a3
    80008354:	03859713          	slli	a4,a1,0x38
    80008358:	00389813          	slli	a6,a7,0x3
    8000835c:	00f507b3          	add	a5,a0,a5
    80008360:	00e6e733          	or	a4,a3,a4
    80008364:	000e089b          	sext.w	a7,t3
    80008368:	00f806b3          	add	a3,a6,a5
    8000836c:	00e7b023          	sd	a4,0(a5)
    80008370:	00878793          	addi	a5,a5,8
    80008374:	fed79ce3          	bne	a5,a3,8000836c <__memset+0xd4>
    80008378:	ff8e7793          	andi	a5,t3,-8
    8000837c:	0007871b          	sext.w	a4,a5
    80008380:	01d787bb          	addw	a5,a5,t4
    80008384:	0ce88e63          	beq	a7,a4,80008460 <__memset+0x1c8>
    80008388:	00f50733          	add	a4,a0,a5
    8000838c:	00b70023          	sb	a1,0(a4)
    80008390:	0017871b          	addiw	a4,a5,1
    80008394:	0cc77663          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    80008398:	00e50733          	add	a4,a0,a4
    8000839c:	00b70023          	sb	a1,0(a4)
    800083a0:	0027871b          	addiw	a4,a5,2
    800083a4:	0ac77e63          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    800083a8:	00e50733          	add	a4,a0,a4
    800083ac:	00b70023          	sb	a1,0(a4)
    800083b0:	0037871b          	addiw	a4,a5,3
    800083b4:	0ac77663          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    800083b8:	00e50733          	add	a4,a0,a4
    800083bc:	00b70023          	sb	a1,0(a4)
    800083c0:	0047871b          	addiw	a4,a5,4
    800083c4:	08c77e63          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    800083c8:	00e50733          	add	a4,a0,a4
    800083cc:	00b70023          	sb	a1,0(a4)
    800083d0:	0057871b          	addiw	a4,a5,5
    800083d4:	08c77663          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    800083d8:	00e50733          	add	a4,a0,a4
    800083dc:	00b70023          	sb	a1,0(a4)
    800083e0:	0067871b          	addiw	a4,a5,6
    800083e4:	06c77e63          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    800083e8:	00e50733          	add	a4,a0,a4
    800083ec:	00b70023          	sb	a1,0(a4)
    800083f0:	0077871b          	addiw	a4,a5,7
    800083f4:	06c77663          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    800083f8:	00e50733          	add	a4,a0,a4
    800083fc:	00b70023          	sb	a1,0(a4)
    80008400:	0087871b          	addiw	a4,a5,8
    80008404:	04c77e63          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    80008408:	00e50733          	add	a4,a0,a4
    8000840c:	00b70023          	sb	a1,0(a4)
    80008410:	0097871b          	addiw	a4,a5,9
    80008414:	04c77663          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    80008418:	00e50733          	add	a4,a0,a4
    8000841c:	00b70023          	sb	a1,0(a4)
    80008420:	00a7871b          	addiw	a4,a5,10
    80008424:	02c77e63          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    80008428:	00e50733          	add	a4,a0,a4
    8000842c:	00b70023          	sb	a1,0(a4)
    80008430:	00b7871b          	addiw	a4,a5,11
    80008434:	02c77663          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    80008438:	00e50733          	add	a4,a0,a4
    8000843c:	00b70023          	sb	a1,0(a4)
    80008440:	00c7871b          	addiw	a4,a5,12
    80008444:	00c77e63          	bgeu	a4,a2,80008460 <__memset+0x1c8>
    80008448:	00e50733          	add	a4,a0,a4
    8000844c:	00b70023          	sb	a1,0(a4)
    80008450:	00d7879b          	addiw	a5,a5,13
    80008454:	00c7f663          	bgeu	a5,a2,80008460 <__memset+0x1c8>
    80008458:	00f507b3          	add	a5,a0,a5
    8000845c:	00b78023          	sb	a1,0(a5)
    80008460:	00813403          	ld	s0,8(sp)
    80008464:	01010113          	addi	sp,sp,16
    80008468:	00008067          	ret
    8000846c:	00b00693          	li	a3,11
    80008470:	e55ff06f          	j	800082c4 <__memset+0x2c>
    80008474:	00300e93          	li	t4,3
    80008478:	ea5ff06f          	j	8000831c <__memset+0x84>
    8000847c:	00100e93          	li	t4,1
    80008480:	e9dff06f          	j	8000831c <__memset+0x84>
    80008484:	00000e93          	li	t4,0
    80008488:	e95ff06f          	j	8000831c <__memset+0x84>
    8000848c:	00000793          	li	a5,0
    80008490:	ef9ff06f          	j	80008388 <__memset+0xf0>
    80008494:	00200e93          	li	t4,2
    80008498:	e85ff06f          	j	8000831c <__memset+0x84>
    8000849c:	00400e93          	li	t4,4
    800084a0:	e7dff06f          	j	8000831c <__memset+0x84>
    800084a4:	00500e93          	li	t4,5
    800084a8:	e75ff06f          	j	8000831c <__memset+0x84>
    800084ac:	00600e93          	li	t4,6
    800084b0:	e6dff06f          	j	8000831c <__memset+0x84>

00000000800084b4 <__memmove>:
    800084b4:	ff010113          	addi	sp,sp,-16
    800084b8:	00813423          	sd	s0,8(sp)
    800084bc:	01010413          	addi	s0,sp,16
    800084c0:	0e060863          	beqz	a2,800085b0 <__memmove+0xfc>
    800084c4:	fff6069b          	addiw	a3,a2,-1
    800084c8:	0006881b          	sext.w	a6,a3
    800084cc:	0ea5e863          	bltu	a1,a0,800085bc <__memmove+0x108>
    800084d0:	00758713          	addi	a4,a1,7
    800084d4:	00a5e7b3          	or	a5,a1,a0
    800084d8:	40a70733          	sub	a4,a4,a0
    800084dc:	0077f793          	andi	a5,a5,7
    800084e0:	00f73713          	sltiu	a4,a4,15
    800084e4:	00174713          	xori	a4,a4,1
    800084e8:	0017b793          	seqz	a5,a5
    800084ec:	00e7f7b3          	and	a5,a5,a4
    800084f0:	10078863          	beqz	a5,80008600 <__memmove+0x14c>
    800084f4:	00900793          	li	a5,9
    800084f8:	1107f463          	bgeu	a5,a6,80008600 <__memmove+0x14c>
    800084fc:	0036581b          	srliw	a6,a2,0x3
    80008500:	fff8081b          	addiw	a6,a6,-1
    80008504:	02081813          	slli	a6,a6,0x20
    80008508:	01d85893          	srli	a7,a6,0x1d
    8000850c:	00858813          	addi	a6,a1,8
    80008510:	00058793          	mv	a5,a1
    80008514:	00050713          	mv	a4,a0
    80008518:	01088833          	add	a6,a7,a6
    8000851c:	0007b883          	ld	a7,0(a5)
    80008520:	00878793          	addi	a5,a5,8
    80008524:	00870713          	addi	a4,a4,8
    80008528:	ff173c23          	sd	a7,-8(a4)
    8000852c:	ff0798e3          	bne	a5,a6,8000851c <__memmove+0x68>
    80008530:	ff867713          	andi	a4,a2,-8
    80008534:	02071793          	slli	a5,a4,0x20
    80008538:	0207d793          	srli	a5,a5,0x20
    8000853c:	00f585b3          	add	a1,a1,a5
    80008540:	40e686bb          	subw	a3,a3,a4
    80008544:	00f507b3          	add	a5,a0,a5
    80008548:	06e60463          	beq	a2,a4,800085b0 <__memmove+0xfc>
    8000854c:	0005c703          	lbu	a4,0(a1)
    80008550:	00e78023          	sb	a4,0(a5)
    80008554:	04068e63          	beqz	a3,800085b0 <__memmove+0xfc>
    80008558:	0015c603          	lbu	a2,1(a1)
    8000855c:	00100713          	li	a4,1
    80008560:	00c780a3          	sb	a2,1(a5)
    80008564:	04e68663          	beq	a3,a4,800085b0 <__memmove+0xfc>
    80008568:	0025c603          	lbu	a2,2(a1)
    8000856c:	00200713          	li	a4,2
    80008570:	00c78123          	sb	a2,2(a5)
    80008574:	02e68e63          	beq	a3,a4,800085b0 <__memmove+0xfc>
    80008578:	0035c603          	lbu	a2,3(a1)
    8000857c:	00300713          	li	a4,3
    80008580:	00c781a3          	sb	a2,3(a5)
    80008584:	02e68663          	beq	a3,a4,800085b0 <__memmove+0xfc>
    80008588:	0045c603          	lbu	a2,4(a1)
    8000858c:	00400713          	li	a4,4
    80008590:	00c78223          	sb	a2,4(a5)
    80008594:	00e68e63          	beq	a3,a4,800085b0 <__memmove+0xfc>
    80008598:	0055c603          	lbu	a2,5(a1)
    8000859c:	00500713          	li	a4,5
    800085a0:	00c782a3          	sb	a2,5(a5)
    800085a4:	00e68663          	beq	a3,a4,800085b0 <__memmove+0xfc>
    800085a8:	0065c703          	lbu	a4,6(a1)
    800085ac:	00e78323          	sb	a4,6(a5)
    800085b0:	00813403          	ld	s0,8(sp)
    800085b4:	01010113          	addi	sp,sp,16
    800085b8:	00008067          	ret
    800085bc:	02061713          	slli	a4,a2,0x20
    800085c0:	02075713          	srli	a4,a4,0x20
    800085c4:	00e587b3          	add	a5,a1,a4
    800085c8:	f0f574e3          	bgeu	a0,a5,800084d0 <__memmove+0x1c>
    800085cc:	02069613          	slli	a2,a3,0x20
    800085d0:	02065613          	srli	a2,a2,0x20
    800085d4:	fff64613          	not	a2,a2
    800085d8:	00e50733          	add	a4,a0,a4
    800085dc:	00c78633          	add	a2,a5,a2
    800085e0:	fff7c683          	lbu	a3,-1(a5)
    800085e4:	fff78793          	addi	a5,a5,-1
    800085e8:	fff70713          	addi	a4,a4,-1
    800085ec:	00d70023          	sb	a3,0(a4)
    800085f0:	fec798e3          	bne	a5,a2,800085e0 <__memmove+0x12c>
    800085f4:	00813403          	ld	s0,8(sp)
    800085f8:	01010113          	addi	sp,sp,16
    800085fc:	00008067          	ret
    80008600:	02069713          	slli	a4,a3,0x20
    80008604:	02075713          	srli	a4,a4,0x20
    80008608:	00170713          	addi	a4,a4,1
    8000860c:	00e50733          	add	a4,a0,a4
    80008610:	00050793          	mv	a5,a0
    80008614:	0005c683          	lbu	a3,0(a1)
    80008618:	00178793          	addi	a5,a5,1
    8000861c:	00158593          	addi	a1,a1,1
    80008620:	fed78fa3          	sb	a3,-1(a5)
    80008624:	fee798e3          	bne	a5,a4,80008614 <__memmove+0x160>
    80008628:	f89ff06f          	j	800085b0 <__memmove+0xfc>

000000008000862c <__putc>:
    8000862c:	fe010113          	addi	sp,sp,-32
    80008630:	00813823          	sd	s0,16(sp)
    80008634:	00113c23          	sd	ra,24(sp)
    80008638:	02010413          	addi	s0,sp,32
    8000863c:	00050793          	mv	a5,a0
    80008640:	fef40593          	addi	a1,s0,-17
    80008644:	00100613          	li	a2,1
    80008648:	00000513          	li	a0,0
    8000864c:	fef407a3          	sb	a5,-17(s0)
    80008650:	fffff097          	auipc	ra,0xfffff
    80008654:	b3c080e7          	jalr	-1220(ra) # 8000718c <console_write>
    80008658:	01813083          	ld	ra,24(sp)
    8000865c:	01013403          	ld	s0,16(sp)
    80008660:	02010113          	addi	sp,sp,32
    80008664:	00008067          	ret

0000000080008668 <__getc>:
    80008668:	fe010113          	addi	sp,sp,-32
    8000866c:	00813823          	sd	s0,16(sp)
    80008670:	00113c23          	sd	ra,24(sp)
    80008674:	02010413          	addi	s0,sp,32
    80008678:	fe840593          	addi	a1,s0,-24
    8000867c:	00100613          	li	a2,1
    80008680:	00000513          	li	a0,0
    80008684:	fffff097          	auipc	ra,0xfffff
    80008688:	ae8080e7          	jalr	-1304(ra) # 8000716c <console_read>
    8000868c:	fe844503          	lbu	a0,-24(s0)
    80008690:	01813083          	ld	ra,24(sp)
    80008694:	01013403          	ld	s0,16(sp)
    80008698:	02010113          	addi	sp,sp,32
    8000869c:	00008067          	ret

00000000800086a0 <console_handler>:
    800086a0:	fe010113          	addi	sp,sp,-32
    800086a4:	00813823          	sd	s0,16(sp)
    800086a8:	00113c23          	sd	ra,24(sp)
    800086ac:	00913423          	sd	s1,8(sp)
    800086b0:	02010413          	addi	s0,sp,32
    800086b4:	14202773          	csrr	a4,scause
    800086b8:	100027f3          	csrr	a5,sstatus
    800086bc:	0027f793          	andi	a5,a5,2
    800086c0:	06079e63          	bnez	a5,8000873c <console_handler+0x9c>
    800086c4:	00074c63          	bltz	a4,800086dc <console_handler+0x3c>
    800086c8:	01813083          	ld	ra,24(sp)
    800086cc:	01013403          	ld	s0,16(sp)
    800086d0:	00813483          	ld	s1,8(sp)
    800086d4:	02010113          	addi	sp,sp,32
    800086d8:	00008067          	ret
    800086dc:	0ff77713          	andi	a4,a4,255
    800086e0:	00900793          	li	a5,9
    800086e4:	fef712e3          	bne	a4,a5,800086c8 <console_handler+0x28>
    800086e8:	ffffe097          	auipc	ra,0xffffe
    800086ec:	6dc080e7          	jalr	1756(ra) # 80006dc4 <plic_claim>
    800086f0:	00a00793          	li	a5,10
    800086f4:	00050493          	mv	s1,a0
    800086f8:	02f50c63          	beq	a0,a5,80008730 <console_handler+0x90>
    800086fc:	fc0506e3          	beqz	a0,800086c8 <console_handler+0x28>
    80008700:	00050593          	mv	a1,a0
    80008704:	00001517          	auipc	a0,0x1
    80008708:	07450513          	addi	a0,a0,116 # 80009778 <_ZTV9Semaphore+0xf0>
    8000870c:	fffff097          	auipc	ra,0xfffff
    80008710:	afc080e7          	jalr	-1284(ra) # 80007208 <__printf>
    80008714:	01013403          	ld	s0,16(sp)
    80008718:	01813083          	ld	ra,24(sp)
    8000871c:	00048513          	mv	a0,s1
    80008720:	00813483          	ld	s1,8(sp)
    80008724:	02010113          	addi	sp,sp,32
    80008728:	ffffe317          	auipc	t1,0xffffe
    8000872c:	6d430067          	jr	1748(t1) # 80006dfc <plic_complete>
    80008730:	fffff097          	auipc	ra,0xfffff
    80008734:	3e0080e7          	jalr	992(ra) # 80007b10 <uartintr>
    80008738:	fddff06f          	j	80008714 <console_handler+0x74>
    8000873c:	00001517          	auipc	a0,0x1
    80008740:	13c50513          	addi	a0,a0,316 # 80009878 <digits+0x78>
    80008744:	fffff097          	auipc	ra,0xfffff
    80008748:	a68080e7          	jalr	-1432(ra) # 800071ac <panic>
	...
