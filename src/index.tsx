import { NativeModules } from 'react-native';

type ReactNativeKakaoLoginType = {
  multiply(a: number, b: number): Promise<number>;
};

const { ReactNativeKakaoLogin } = NativeModules;

export default ReactNativeKakaoLogin as ReactNativeKakaoLoginType;
